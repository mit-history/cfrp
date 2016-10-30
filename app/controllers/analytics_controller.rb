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
    return { etag: warehouse_stamp['warehouse_hash'] }
#  NB Default is to invalidate only based on hash of database contents.
#     To invalidate cache every time warehouse updates, uncomment this line:
#           ... last_modified: warehouse_stamp['created_at'].to_time }
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

    plays              = {}
    performances       = {}

    seating_categories = Arel::Table.new('warehouse.seating_category_dim')
    [1,2,3,4,'n'].each do |i|
      plays[i.to_s]        = Arel::Table.new('warehouse.play_dim').alias("play_#{i}")
      performances[i.to_s] = Arel::Table.new('warehouse.performance_dim').alias("performance_#{i}")
    end

    # dimensions

    dims = {}
    join_dims = []

    # aggregate

    # BUG IN AREL.  Circumlocutions necessary because Arel assumes a single aggregate function per expression
    # e.g., unweighted mean_receipts in a just world:  ([sales_facts[:price] * sales_facts[:sold]).sum / sales_facts[:date].count(true))

    receipts_function = Arel::Nodes::NamedFunction.new('SUM', [sales_facts[:price] * sales_facts[:sold]])
    weighted_receipts_function = Arel::Nodes::NamedFunction.new('SUM', [sales_facts[:price] * sales_facts[:sold] * sales_facts[:weighting]])

    projection = case agg
      when /^default$/
        Arel.sql('*').count
      when /^min\(date\)$/
        sales_facts[:date].minimum
      when /^max\(date\)$/
        sales_facts[:date].maximum
      when /^performances_days$/
        sales_facts[:date].count(true)
      when /^sum_receipts$/
        receipts_function
      when /^sum_receipts_weighted$/
        weighted_receipts_function
      when /^mean_receipts_day$/
        Arel::Nodes::Division.new( receipts_function, sales_facts[:date].count(true) )
      when /^mean_receipts_day_weighted$/
        Arel::Nodes::Division.new( weighted_receipts_function, sales_facts[:date].count(true))
      when /^mean_price$/
        sold_function = Arel::Nodes::NamedFunction.new('SUM', [ sales_facts[:sold] ])
        Arel::Nodes::Division.new( receipts_function, sold_function )
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
      when /^author_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:author]
      when /^title_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:title]
      when /^genre_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:genre]
      when /^acts_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:acts]
      when /^prose_vers_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:prose_vers]
      when /^prologue_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:prologue]
      when /^musique_danse_machine_(\d|n)/
        join_dims << "play_#{$1}"
        plays[$1][:musique_danse_machine]
      when /^creation_season_(\d|n)/
        join_dims << "play_#{$1}"
        Arel::Nodes::NamedFunction.new "warehouse.cfrp_season", [ plays[$1][:date_de_creation] ]

      # Soirée (supplémentaire)
      when /^free_entry_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:free_access]
      when /^reprise_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:reprise]
      when /^newactor_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:newactor]
      when /^debut_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:debut]
      when /^firstrun_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:firstrun]
      when /^reprise_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:reprise]
      when /^ex_attendance_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:ex_attendance]
      when /^ex_representation_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:ex_representation]
      when /^ex_place_(\d|n)/
        join_dims << "performance_#{$1}"
        performances[$1][:ex_place]

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
      when /^play_(\d|n)/
        tbl = plays[$1]
        subs = $1=='n' ? 1..4 : [$1]
        cols = subs.map { |i| "play_#{i}_id" }
        query = query.join(tbl).on(tbl[:id].in(cols.map { |col| sales_facts[col] }))
      when /^performance_(\d|n)/
        tbl = performances[$1]
        subs = $1=='n' ? 1..4 : [$1]
        cols = subs.map { |i| "performance_#{i}_id" }
        query = query.join(tbl).on(tbl[:id].in(cols.map { |col| sales_facts[col] }))
      when /^(.+)_seating_category/
        col = "#{$1}_seating_category_id"
        query = query.join(seating_categories)
                     .on(seating_categories[:id].eq(sales_facts[col]))

      else
        throw "Unknown dimension key: #{name}"
      end
    end

    # N.B. aggregate definitions need to accommodate the outlier case when
    #      duplicate fact rows are returned because a value matches multiple dimensions
    #      e.g. for a night with play-1: Voltaire, play-2: Voltaire, the sum of receipts
    #      is not double.  distinct in a subquery accomplishes this.

    shellquery = sales_facts
    query = query.project(sales_facts[:ticket_sales_id])

    dim_names.each do |name|
      sql_label = name.parameterize.underscore
      expr = dims[sql_label].dup
      query = query.project(expr.as(sql_label))
      shellquery = shellquery.project(sql_label).group(sql_label).order(sql_label)
    end

    filters.each do |name, values|
      sql_label = name.parameterize.underscore
      expr = dims[name].dup
      cond = pred(name, expr, values)
      query = query.where(cond)
    end

    query.distinct
    query = query.as('distinct_facts')

    shellquery = shellquery.join(query).on(sales_facts[:ticket_sales_id].eq(query[:ticket_sales_id]))
    shellquery = shellquery.project(projection.as('value'))

    # execute

    connection.select_rows(shellquery.to_sql)
  end

  def self.pred(name, expr, *values)
    case name
    when /\.lt$/
      expr.lt_all(values)
    when /\.gt$/
      expr.gt_all(values)
    when /\.in$/, /^[^\.]+$/
      expr.in(*values)

    else
      throw "Cannot parse operator ending #{name}"
    end
  end

end
