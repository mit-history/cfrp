require 'csv'

class AnalyticsController < ApplicationController

  def dimension
    if stale?(warehouse_cache_key) then

      conn = ActiveRecord::Base.connection

      dim = params[:dim]

      AnalyticsController.domain(conn, dim)

    end
  end

  def aggregate
    if stale?(warehouse_cache_key) then

      conn = ActiveRecord::Base.connection

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

  def warehouse_cache_key
    conn = ActiveRecord::Base.connection
    warehouse_stamp = conn.select_one("SELECT md5, created_at FROM warehouse.warehouse_hash")

    next_refresh = warehouse_stamp['created_at'].to_time + 1.day + 30.minutes
    expires_in(next_refresh - Time.current, public: true)
    return { etag: warehouse_stamp['warehouse_hash'],
             last_modified: warehouse_stamp['created_at'].to_time }
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

    plays              = []
    performances       = []

    seating_categories = Arel::Table.new('warehouse.seating_category_dim')
    (1..4).each do |i|
      plays[i]        = Arel::Table.new('warehouse.play_dim').alias("play_#{i}")
      performances[i] = Arel::Table.new('warehouse.performance_dim').alias("performance_#{i}")
    end

    # dimensions

    dims = {}
    join_dims = []

    # aggregate

    projection = case agg
      when /^default/
        Arel.sql('*').count
      when /^min\(date\)/
        sales_facts[:date].minimum
      when /^max\(date\)/
        sales_facts[:date].maximum
      when /^performances_days/
        sales_facts[:date].count(true)
      when /^sum_receipts/
        (sales_facts[:price] * sales_facts[:sold]).sum
      when /^mean_receipts_day/
        # BUG IN AREL.  This circumlocution necessary because Arel assumes a single aggregate function per expression
        # in a just world, it would be:  ([sales_facts[:price] * sales_facts[:sold]).sum / sales_facts[:date].count(true))
        sum_function = Arel::Nodes::NamedFunction.new('SUM', [sales_facts[:price] * sales_facts[:sold]])
        Arel::Nodes::Division.new( sum_function, sales_facts[:date].count(true))
      when /^mean_price/
        sales_facts[:price].average
      when /^count_authors_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:author].count(true)
      when /^count_titles_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:title].count(true)
      else
        throw "Unkown aggregate: #{agg}"
      end

    # construct query

    query = sales_facts

    expr_names = (dim_names + filters.keys).uniq

    expr_names.each do |name|
      sql_label = name.parameterize.underscore

      expr = case name
      # Temps
      when /^decade/
        decade = Arel::Nodes::NamedFunction.new "date_trunc", [ Arel.sql("'decade'"), sales_facts[:date] ]
        Arel::Nodes::NamedFunction.new "to_char", [ decade, Arel.sql("'YYYY'") ]
      when /^season/
        Arel::Nodes::NamedFunction.new "warehouse.cfrp_season", [ sales_facts[:date] ]
      when /^month/
        Arel::Nodes::NamedFunction.new "to_char", [ sales_facts[:date], Arel.sql("'MM'") ]
      when /^day/
        sales_facts[:date]
      when /^weekday/
        Arel::Nodes::NamedFunction.new "to_char", [ sales_facts[:date], Arel.sql("'D'") ]

      # Soirée
      when /^author_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:author]
      when /^title_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:title]
      when /^genre_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:genre]
      when /^acts_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:acts]
      when /^prose_vers_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:prose_vers]
      when /^prologue_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:prologue]
      when /^musique_danse_machine_(\d+)/
        join_dims << "play_#{$1}"
        plays[$1.to_i][:musique_danse_machine]

      # Soirée (supplémentaire)
      when /^free_entry_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:free_access]
      when /^reprise_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:reprise]
      when /^newactor_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:newactor]
      when /^debut_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:debut]
      when /^firstrun_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:firstrun]
      when /^reprise_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:reprise]
      when /^ex_attendance_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:ex_attendance]
      when /^ex_representation_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:ex_representation]
      when /^ex_place_(\d+)/
        join_dims << "performance_#{$1}"
        performances[$1.to_i][:ex_place]

      # Théâtre
      when /^theater_period/
        join_dims << "ravel_1_seating_category"
        seating_categories[:period]
      when /^seat/
        join_dims << "ravel_1_seating_category"
        seating_categories[:category]

      else
        throw "Unknown dimension: #{name}"
      end

      dims[name] = expr
    end

    join_dims = join_dims.uniq
    logger.debug "joined tables: #{join_dims.join(', ')}"

    join_dims.each do |name|
      case name
      when /^play_(\d+)/
        tbl = plays[$1.to_i]
        col = "play_#{$1}_id"
        query = query.join(tbl).on(tbl[:id].eq(sales_facts[col]))
      when /^performance_(\d+)/
        tbl = performances[$1.to_i]
        col = "performance_#{$1}_id"
        query = query.join(tbl).on(tbl[:id].eq(sales_facts[col]))
      when /^(.+)_seating_category/
        col = "#{$1}_seating_category_id"
        query = query.join(seating_categories)
                     .on(seating_categories[:id].eq(sales_facts[col]))

      else
        throw "Unknown dimension key: #{name}"
      end
    end

    dim_names.each do |name|
      sql_label = name.parameterize.underscore
      expr = dims[sql_label].dup
      query = query.project(expr.as(sql_label)).group(sql_label).order(sql_label)
    end

    filters.each do |name, values|
      sql_label = name.parameterize.underscore
      expr = dims[name].dup
      cond = pred(name, expr, values)
      query = query.where(cond)
    end

    query = query.project(projection.as('value'))

    # execute

    connection.select_rows(query.to_sql)
  end

  def self.pred(name, expr, *values)
    case name
    when /\.lt$/
      expr.lt_all(values)
    when /\.gt$/
      expr.gt_all(values)
    when /\.in$/, /^[^\.]+$/
      expr.in(values)

    else
      throw "Cannot parse operator ending #{name}"
    end
  end

end
