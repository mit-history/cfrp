class PageTextTemplatesController < ApplicationController
  # GET /page_text_templates
  # GET /page_text_templates.xml
  def index
    @page_text_templates = PageTextTemplate.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @page_text_templates }
    end
  end

  # GET /page_text_templates/1
  # GET /page_text_templates/1.xml
  def show
    @page_text_template = PageTextTemplate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @page_text_template }
    end
  end

  # GET /page_text_templates/new
  # GET /page_text_templates/new.xml
  def new
    @page_text_template = PageTextTemplate.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @page_text_template }
    end
  end

  # GET /page_text_templates/1/edit
  def edit
    @page_text_template = PageTextTemplate.find(params[:id])
  end

  # POST /page_text_templates
  # POST /page_text_templates.xml
  def create
    @page_text_template = PageTextTemplate.new(params[:page_text_template])

    respond_to do |format|
      if @page_text_template.save
        format.html { redirect_to(@page_text_template, :notice => 'Page text template was successfully created.') }
        format.xml  { render :xml => @page_text_template, :status => :created, :location => @page_text_template }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page_text_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /page_text_templates/1
  # PUT /page_text_templates/1.xml
  def update
    @page_text_template = PageTextTemplate.find(params[:id])

    respond_to do |format|
      if @page_text_template.update_attributes(params[:page_text_template])
        format.html { redirect_to(@page_text_template, :notice => 'Page text template was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page_text_template.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /page_text_templates/1
  # DELETE /page_text_templates/1.xml
  def destroy
    @page_text_template = PageTextTemplate.find(params[:id])
    @page_text_template.destroy

    respond_to do |format|
      format.html { redirect_to(page_text_templates_url) }
      format.xml  { head :ok }
    end
  end
end
