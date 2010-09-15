class RegistersController < ApplicationController

  include Repertoire::Faceting::Controller

  # GET /registers
  # GET /registers.xml
  def index
    @search = params[:search] || ''
    render

    #@registers = Register.all

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.xml  { render :xml => @registers }
    #end
  end


  # GET /registers/1
  # GET /registers/1.xml
  def show
    @register = Register.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @register }
    end
  end

  # GET /registers/new
  # GET /registers/new.xml
  def new
    @register = Register.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @register }
    end
  end

  # GET /registers/1/edit
  def edit
    @register = Register.find(params[:id])
  end

  # POST /registers
  # POST /registers.xml
  def create
    @register = Register.new(params[:register])

    respond_to do |format|
      if @register.save
        format.html { redirect_to(@register, :notice => 'Register was successfully created.') }
        format.xml  { render :xml => @register, :status => :created, :location => @register }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @register.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registers/1
  # PUT /registers/1.xml
  def update
    @register = Register.find(params[:id])

    respond_to do |format|
      if @register.update_attributes(params[:register])
        format.html { redirect_to(@register, :notice => 'Register was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @register.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registers/1
  # DELETE /registers/1.xml
  def destroy
    @register = Register.find(params[:id])
    @register.destroy

    respond_to do |format|
      format.html { redirect_to(registers_url) }
      format.xml  { head :ok }
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
