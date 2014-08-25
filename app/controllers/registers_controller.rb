class RegistersController < ApplicationController
  include Repertoire::Faceting::Controller

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @search = params[:search] || ''
  end

  def show
    @register = Register.find(params[:id])
  end

  def new
    @register = Register.new
  end

  def edit
    @register = Register.find(params[:id])
    @plays = Play.all
    @people = Person.all
  end

  def create
    @register = Register.new(params[:register])
  end

  def update
    @register = Register.find(params[:id])
    @register.update_attributes!(params[:register])
    redirect_to :action => "edit", :id => @register.id, flash: 'Register was successfully updated.'
  end

  def destroy
    @register = Register.find(params[:id])
    @register.destroy
    redirect_to :action => "index", :notice => 'Register was successfully updated.'
  end

  def results
    filter = params[:filter] || {}
    limit  = params[:limit]  || 20                  # ... avoid returning the entire data set
    offset = params[:offset] || false

#    if stale?(base.facet_cache_key)
      @refined = base.refine(filter)

      @result_count = @refined.count

      @results = @refined.order(:date).includes(:ticket_sales, :plays, :register_images)
      @results = @results.limit(limit) if limit
      @results = @results.offset(offset) if offset

      # N.B. Doing this as a faceted query happens to capture the semantics we want (aggregation
      #      over different seating categories but not across all performances in a double bill ticket).
      #      In bare SQL, separating refinement and aggregation into a subquery is the most direct
      #      translation, e.g.:
      #
      #        SELECT EXTRACT(MONTH FROM date) AS month, EXTRACT(DAY FROM date) AS day, SUM(total_sold) AS tickets
      #        FROM registers JOIN ticket_sales ON (registers.id = ticket_sales.register_id)
      #        WHERE registers.id IN
      #              (SELECT register_id
      #               FROM register_plays
      #               JOIN plays ON (plays.id = play_id)
      #               WHERE plays.author = 'Desforges'
      #               AND ordering = 1)
      #        GROUP BY month, day
      #        ORDER BY month, day;
      #
      # @tickets_by_date = @refined.joins(:ticket_sales).select(['EXTRACT(MONTH FROM date) AS month',
      #                                                          'EXTRACT(DAY FROM date) AS day',
      #                                                          'SUM(total_sold) AS tickets']).group('month', 'day')

      # For the Sept 1. release: use total receipts
      @measure_by_date = @refined.select(['EXTRACT(MONTH FROM date) AS month',
                                          'EXTRACT(DAY FROM date) AS day',
                                          'SUM(total_receipts_recorded_l) AS measure']).group('month', 'day')

      # oh god... for christs sake!?! kill me now
      @seat_order = []
      @seat_names = []
      RegisterPeriodSeatingCategory.joins(:register_period).joins(:seating_category).order(:period, :ordering).select([:seating_category_id, :name]).each_with_index do |rec, i|
        @seat_order[rec.seating_category_id] = i
        @seat_names[rec.seating_category_id] = rec.name
      end

      respond_to do |format|
        format.html { render @results, :layout => false }
        format.json { render :json => @measure_by_date }
      end
#    end
  end

  protected
  def base
    # N.B. to be removed later: for Sept 1 release, only include cleaned data
    Register.where("date >= '1740-04-01' AND date <= '1793-03-26'")
  end

end
