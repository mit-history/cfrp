class RegistersController < ApplicationController
  include Repertoire::Faceting::Controller

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  def index
    @search = params[:search] || ''
    
    render :layout => 'registers'
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
    offset = params[:offset] || 0

    @refined = base.refine(filter)
    count = @refined.count

    @results = @refined.order(:date).includes(:ticket_sales, :plays, :register_images)
    @results = @results.limit(limit) if limit
    @results = @results.offset(offset) if offset

    # retrieve line-item tallies by the correct seating order
    @seat_order = []
    @seat_names = []
    RegisterPeriodSeatingCategory.joins(:register_period).joins(:seating_category).order(:period, :ordering).select([:seating_category_id, :name]).each_with_index do |rec, i|
      @seat_order[rec.seating_category_id] = i
      @seat_names[rec.seating_category_id] = rec.name
    end

    render :partial => 'register', :collection => @results,
           :locals => {:offset => offset, :total => count},
           :layout => false
  end

  protected
  def base
    # For May 1 2015 release, exclude archived or unchecked registers
    # TODO.  ActiveRecord not respecting :joins clause, so we match directly on id
    Register.where(:verification_state_id => [1,6])
  end

end
