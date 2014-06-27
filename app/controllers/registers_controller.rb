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
    limit  = params[:limit]  || false
    offset = params[:offset] || false

    if stale?(base.facet_cache_key)
      @refined = base.refine(filter)

      @results = @refined
      @refined = @results.limit(limit) if limit
      @refined = @results.offset(offset) if offset

      @tickets_by_date = @refined.joins(:ticket_sales).select(['EXTRACT(MONTH FROM date) AS month',
                                                               'EXTRACT(DAY FROM date) AS day',
                                                               'SUM(total_sold) AS tickets']).group('month', 'day')

      respond_to do |format|
        format.html { render @results, :layout => false }
        format.json { render :json => @tickets_by_date }
      end
    end
  end

  protected
  def base
    Register
  end

end
