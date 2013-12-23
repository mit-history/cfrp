class RegistersController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :edit, :create, :update, :destroy]

  include Repertoire::Faceting::Controller

  def index
    @search = params[:search] || ''
    # @q = Register.ransack(params[:q]) # <=========
    #   if params[:q].nil?
    #     @registers = Register.all
    #   else
    #     @registers = @q.result(:distinct => true).order("created_at desc")
    #   end
    # @registers = Register.all
    # @registers = Register.paginate(:page => params[:page])
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
  end

  def create
    @register = Register.new(params[:register])
  end

  def update
    @register = Register.find(params[:id])
    @register.update_attributes!(params[:register])
    redirect_to :action => "edit", :id => @register.id, :notice => 'Register was successfully updated.'
  end

  def destroy
    @register = Register.find(params[:id])
    @register.destroy
    redirect_to :action => "index", :notice => 'Register was successfully updated.'
  end


  # Web-service to return the results of a query, given existing filter
  # requirements. Over-ride this method if you need to specify additional
  # query parms for faceting results.
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

  # webservice bases

  protected
  def base(name=nil)
    search = "%#{params[:search]}%"
    base = Register.where(["season ilike ?", search])
    name ? base.facet(name) : base
  end

end
