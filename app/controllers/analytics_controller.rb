require 'csv'

class AnalyticsController < ApplicationController

  def dimension
  	dim = params[:dim]

    conn = ActiveRecord::Base.connection

  	AnalyticsController.domain(conn, dim)
  end

  def aggregate

    conn = ActiveRecord::Base.connection

    warehouse_hash = conn.select_value("SELECT md5 FROM warehouse.warehouse_hash")

    # HTTP caching
    if stale?(etag: warehouse_hash, public: true) then

      # prepare params

    	agg = params[:agg] || :default
      dims = params[:axis] || []

      filter = {}
      params.each do |key, value|
        if key =~ /filter\.(.+)/
          dim = $1
          filter[dim] = value
        end
      end

      # run query
      filter.each do |key, val|
        logger.debug("#{key}: #{val}")
      end

    	@data = AnalyticsController.aggregate(conn, agg, dims, filter)

      @csv = CSV.generate do |csv|
        csv << dims + [agg]
        @data.each do |item|
          csv << item
        end
      end

      # output csv

      respond_to do |format|
      	format.csv { render :text => @csv }
      end

    end
  end

  def image_url
    date = params[:date]
    @register = Register.verified.find_by_date(date)
    @url = @register.recto_image.image.url(:original)

    render :text => @url
  end


  # library methods (location is temporary)

  def self.domain(connection, dim_name)
    sales_facts = Arel::Table.new('warehouse.sales_facts')
    sql_label = name.parameterize.underscore
    join_dims = []
    dim = dim_defn(dim_name, join_dims)

    query = sales_facts.project(dim.as(sql_label))
                       .group(sql_label)
                       .order(sql_label)

    connection.select_values(query.to_sql)
  end

  def self.aggregate(connection, agg, dim_names, filters={})
    sales_facts = Arel::Table.new('warehouse.sales_facts')

    plays = Arel::Table.new('warehouse.play_dim')
    performances = Arel::Table.new('warehouse.performance_dim')
    seating_categories = Arel::Table.new('warehouse.seating_category_dim')

    # aggregate

    projection = case agg
      when /default/
        Arel.sql('*').count
      when /min\(date\)/
        sales_facts[:date].minimum
      when /max\(date\)/
        sales_facts[:date].maximum
      when /performances_days/
        sales_facts[:date].count(true)
      when /sum_receipts/
        (sales_facts[:price] * sales_facts[:sold]).sum
      when /mean_receipts_day/
        # BUG IN AREL.  This circumlocution necessary because Arel assumes a single aggregate function per expression
        # in a just world, it would be:  ([sales_facts[:price] * sales_facts[:sold]).sum / sales_facts[:date].count(true))
        sum_function = Arel::Nodes::NamedFunction.new('SUM', [sales_facts[:price] * sales_facts[:sold]])
        Arel::Nodes::Division.new( sum_function, sales_facts[:date].count(true))
      when /mean_price/
        sales_facts[:price].average
      else
        throw "Unkown aggregate: #{agg}"
      end

    # dimensions

    dims = {}
    join_dims = []

    dim_names.each do |name|
      sql_label = name.parameterize.underscore
      dims[sql_label] = dim_defn(name, join_dims)
    end

    # construct query

    query = sales_facts

    filters.each do |name, values|
      sql_label = name.parameterize.underscore

      if expr = dims[sql_label] then
        expr = expr.dup
      else
        expr = dim_defn(name, join_dims)        # TODO.  has side effects in join_dims...
      end

      query = query.where(expr.in(values))
    end

    join_dims = join_dims.uniq

    logger.debug "joined tables: #{join_dims.join(', ')}"

    join_dims.each do |name|
      case name
      when /play_(\d+)/
        col = "play_#{$1}_id"
        query = query.join(plays).on(plays[:id].eq(sales_facts[col]))
      when /performance_(\d+)/
        col = "performance_#{$1}_id"
        query = query.join(performances).on(performances[:id].eq(sales_facts[col]))
      when /(.+)_seating_category/
        col = "#{$1}_seating_category_id"
        query = query.join(seating_categories)
                     .on(seating_categories[:id].eq(sales_facts[col]))
      else
        throw "Unknown dimension key: #{name}"
      end
    end

    dims.each do |name, expr|
      query = query.project(expr.as(name)).group(name).order(name)
    end

    query = query.project(projection.as('value'))

    # execute

    connection.select_rows(query.to_sql)
  end

  def self.dim_defn(name, join_dims)
    sales_facts = Arel::Table.new('warehouse.sales_facts')

    plays = Arel::Table.new('warehouse.play_dim')
    performances = Arel::Table.new('warehouse.performance_dim')
    seating_categories = Arel::Table.new('warehouse.seating_category_dim')

    case name
    # Temps
    when 'decade'
      decade = Arel::Nodes::NamedFunction.new "date_trunc", [ Arel.sql("'decade'"), sales_facts[:date] ]
      Arel::Nodes::NamedFunction.new "to_char", [ decade, Arel.sql("'YYYY'") ]
    when 'season'
      Arel::Nodes::NamedFunction.new "warehouse.cfrp_season", [ sales_facts[:date] ]
    when 'month'
      Arel::Nodes::NamedFunction.new "to_char", [ sales_facts[:date], Arel.sql("'MM'") ]
    when 'day'
      sales_facts[:date]
    when 'weekday'
      Arel::Nodes::NamedFunction.new "to_char", [ sales_facts[:date], Arel.sql("'D'") ]

    # Soirée
    when /author_(\d+)/
      join_dims << "play_#{$1}"
      plays[:author]
    when /title_(\d+)/
      join_dims << "play_#{$1}"
      plays[:title]
    when /genre_(\d+)/
      join_dims << "play_#{$1}"
      plays[:genre]
    when /acts_(\d+)/
      join_dims << "play_#{$1}"
      plays[:acts]
    when /prose_vers_(\d+)/
      join_dims << "play_#{$1}"
      plays[:prose_vers]
    when /prologue_(\d+)/
      join_dims << "play_#{$1}"
      plays[:prologue]
    when /musique_danse_machine_(\d+)/
      join_dims << "play_#{$1}"
      plays[:musique_danse_machine]

    # Soirée (supplémentaire)
    when /free_entry_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:free_access]
    when /reprise_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:reprise]
    when /newactor_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:newactor]
    when /debut_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:debut]
    when /firstrun_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:firstrun]
    when /reprise_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:reprise]
    when /ex_attendance_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:ex_attendance]
    when /ex_representation_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:ex_representation]
    when /ex_place_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:ex_place]

    # Théâtre
    when /theater_period/
      join_dims << "ravel_1_seating_category"
      seating_categories[:period]
    when /seat/
      join_dims << "ravel_1_seating_category"
      seating_categories[:category]

    else
      throw "Unknown dimension: #{name}"
    end
  end


end
