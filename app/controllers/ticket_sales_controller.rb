class TicketSalesController < ApplicationController
  # GET /ticket_sales
  # GET /ticket_sales.xml
  def index
    @ticket_sales = TicketSale.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ticket_sales }
    end
  end

  # GET /ticket_sales/1
  # GET /ticket_sales/1.xml
  def show
    @ticket_sale = TicketSale.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ticket_sale }
    end
  end

  # GET /ticket_sales/new
  # GET /ticket_sales/new.xml
  def new
    @ticket_sale = TicketSale.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket_sale }
    end
  end

  # GET /ticket_sales/1/edit
  def edit
    @ticket_sale = TicketSale.find(params[:id])
  end

  # POST /ticket_sales
  # POST /ticket_sales.xml
  def create
    @ticket_sale = TicketSale.new(params[:ticket_sale])

    respond_to do |format|
      if @ticket_sale.save
        format.html { redirect_to(@ticket_sale, :notice => 'Ticket sale was successfully created.') }
        format.xml  { render :xml => @ticket_sale, :status => :created, :location => @ticket_sale }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket_sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_sales/1
  # PUT /ticket_sales/1.xml
  def update
    @ticket_sale = TicketSale.find(params[:id])

    respond_to do |format|
      if @ticket_sale.update_attributes(params[:ticket_sale])
        format.html { redirect_to(@ticket_sale, :notice => 'Ticket sale was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket_sale.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_sales/1
  # DELETE /ticket_sales/1.xml
  def destroy
    @ticket_sale = TicketSale.find(params[:id])
    @ticket_sale.destroy

    respond_to do |format|
      format.html { redirect_to(ticket_sales_url) }
      format.xml  { head :ok }
    end
  end
end
