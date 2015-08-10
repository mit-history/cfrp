require 'csv'

class AnalyticsController < ApplicationController

  DIMENSIONS = [
  ]

  AGGREGATES = [ 'Représentations(jours)',
                 'Somme(recette)',
                 'Moyenne(recette/jour)',
                 'Moyenne(prix)' ]

  def dimensions
    @csv = CSV.generate do |csv|
      csv << ['Dimension']
      DIMENSIONS.each do |agg|
        csv << [ agg ]
      end
    end

    respond_to do |format|
      format.csv { render :text => @csv }
    end
  end

  def aggregates
    @csv = CSV.generate do |csv|
      csv << ['Aggregate']
      AGGREGATES.each do |agg|
        csv << [ agg ]
      end
    end

    respond_to do |format|
      format.csv { render :text => @csv }
    end
  end

  def dimension
  	dim = params[:dim]

    conn = ActiveRecord::Base.connection

  	AnalyticsController.domain(conn, dim)
  end

  def aggregate

    conn = ActiveRecord::Base.connection

    warehouse_stamp = conn.select_value("SELECT hash_stamp FROM fact_stamps")    

    # HTTP caching
    if stale?(etag: warehouse_stamp, public: true) then

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
    facts = Arel::Table.new(:facts)
    sql_label = name.parameterize.underscore
    join_dims = []
    dim = dim_defn(dim_name, join_dims)

    query = facts.project(dim.as(sql_label)).group(sql_label).order(sql_label)

    connection.select_values(query.to_sql)
  end

  def self.aggregate(connection, agg, dim_names, filters={})
    facts = Arel::Table.new(:facts)

    registers = Arel::Table.new(:registers)
    plays = Arel::Table.new(:plays)
    performances = Arel::Table.new(:register_plays)
    seating_category_profile = Arel::Table.new(:seating_category_profile)

    # aggregate

    projection = case agg
      when /default/
        Arel.sql('*').count
      when /min\(date\)/
        facts[:date].minimum
      when /max\(date\)/
        facts[:date].maximum
      when /Représentations\(jours\)/
        facts[:date].count(true)
      when /Somme\(recette\)/
        (facts[:price] * facts[:sold]).sum
      when /Moyenne\(recette\/jour\)/
        (facts[:price] * facts[:sold]).average
      when /Moyenne\(prix\)/
        facts[:price].average
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

    query = facts

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
      when /registers/
        query = query.join(registers).on(registers[:id].eq(facts[:register_id]))
        registers[:id]
      when /play_(\d+)/
        col = "play_#{$1}_id"
        query = query.join(plays).on(plays[:id].eq(facts[col]))
      when /performance_(\d+)/
        col = "performance_#{$1}_id"
        query = query.join(performances).on(performances[:id].eq(facts[col]))
      when /(.+)_seating_category_profile/
        col = "#{$1}_seating_category_profile_id"
        query = query.join(seating_category_profile).on(seating_category_profile[:id].eq(facts[col]))
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
    facts = Arel::Table.new(:facts)

    registers = Arel::Table.new(:registers)
    plays = Arel::Table.new(:plays)
    performances = Arel::Table.new(:register_plays)
    seating_category_profile = Arel::Table.new(:seating_category_profile)

    case name
    # Temps
    when 'Décennie'
      decade = Arel::Nodes::NamedFunction.new "date_trunc", [ Arel.sql("'decade'"), facts[:date] ]
      Arel::Nodes::NamedFunction.new "date_part", [ Arel.sql("'year'"), decade ]
    when 'Saison'
      join_dims << 'registers'
      registers[:season]
    when 'Mois'
      Arel::Nodes::NamedFunction.new "date_part", [ Arel.sql("'month'"), facts[:date] ]
    when 'Jour'
      facts[:date]
    when 'Jour de la semaine'
      Arel::Nodes::NamedFunction.new "date_part", [ Arel.sql("'dow'"), facts[:date] ]

    # Soirée
    when /Auteur_(\d+)/
      join_dims << "play_#{$1}"
      plays[:author]
    when /Pièce_(\d+)/
      join_dims << "play_#{$1}"
      plays[:title]
    when /Genre_(\d+)/
      join_dims << "play_#{$1}"
      plays[:genre]
    when /Acte\(s\)_(\d+)/
      join_dims << "play_#{$1}"
      plays[:acts]
    when /Prose\/Vers_(\d+)/
      join_dims << "play_#{$1}"
      plays[:prose_vers]
    when /Prologue_(\d+)/
      join_dims << "play_#{$1}"
      plays[:prologue]
    when /Musique\/Danse\/Machine_(\d+)/
      join_dims << "play_#{$1}"
      plays[:musique_danse_machine]

    # Soirée (supplémentaire)
    when /Prologue_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:prologue]
    when /Musique\/Danse\/Machine_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:musique_danse_machine]
    when /Gratuit_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:free_access]
    when /Reprise_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:reprise]
    when /Nouveau Acteur_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:newactor]
    when /Début_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:debut]
    when /First Run_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:firstrun]
    when /Reprise_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:reprise]
    when /Présence exceptionelle_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:ex_attendance]
    when /Répresentation exceptionelles_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:ex_representation]
    when /ExPlace_(\d+)/
      join_dims << "performance_#{$1}"
      performances[:ex_place]

    # Théâtre
    when /Théâtre \+ Period/
      join_dims << "ravel_1_seating_category_profile"
      seating_category_profile[:period]
    when /Place/
      join_dims << "ravel_1_seating_category_profile"
      seating_category_profile[:category]

    else
      throw "Unknown dimension: #{name}"
    end
  end


end
