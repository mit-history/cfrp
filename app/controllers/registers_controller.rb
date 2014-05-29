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

    @total = base.refine(filter)
    @refined = @total.limit(limit) if limit
    @refined = @refined.offset(offset) if offset
    @results = @refined.to_a

    @count = @total.count

    respond_to do |format|
      format.html { render @results, :layout => false }
      format.json { render :json => @results }
    end
  end


  protected
  def base
    Register
  end

end
