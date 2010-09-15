class SeatingCategoriesController < ApplicationController
  # GET /seating_categories
  # GET /seating_categories.xml
  def index
    @seating_categories = SeatingCategory.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @seating_categories }
    end
  end

  # GET /seating_categories/1
  # GET /seating_categories/1.xml
  def show
    @seating_category = SeatingCategory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @seating_category }
    end
  end

  # GET /seating_categories/new
  # GET /seating_categories/new.xml
  def new
    @seating_category = SeatingCategory.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @seating_category }
    end
  end

  # GET /seating_categories/1/edit
  def edit
    @seating_category = SeatingCategory.find(params[:id])
  end

  # POST /seating_categories
  # POST /seating_categories.xml
  def create
    @seating_category = SeatingCategory.new(params[:seating_category])

    respond_to do |format|
      if @seating_category.save
        format.html { redirect_to(@seating_category, :notice => 'Seating category was successfully created.') }
        format.xml  { render :xml => @seating_category, :status => :created, :location => @seating_category }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @seating_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /seating_categories/1
  # PUT /seating_categories/1.xml
  def update
    @seating_category = SeatingCategory.find(params[:id])

    respond_to do |format|
      if @seating_category.update_attributes(params[:seating_category])
        format.html { redirect_to(@seating_category, :notice => 'Seating category was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @seating_category.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /seating_categories/1
  # DELETE /seating_categories/1.xml
  def destroy
    @seating_category = SeatingCategory.find(params[:id])
    @seating_category.destroy

    respond_to do |format|
      format.html { redirect_to(seating_categories_url) }
      format.xml  { head :ok }
    end
  end
end
