class RegisterPlaysController < ApplicationController
  # GET /register_plays
  # GET /register_plays.xml
  def index
    @register_plays = RegisterPlay.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @register_plays }
    end
  end

  # GET /register_plays/1
  # GET /register_plays/1.xml
  def show
    @register_play = RegisterPlay.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @register_play }
    end
  end

  # GET /register_plays/new
  # GET /register_plays/new.xml
  def new
    @register_play = RegisterPlay.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @register_play }
    end
  end

  # GET /register_plays/1/edit
  def edit
    @register_play = RegisterPlay.find(params[:id])
  end

  # POST /register_plays
  # POST /register_plays.xml
  def create
    @register_play = RegisterPlay.new(params[:register_play])

    respond_to do |format|
      if @register_play.save
        format.html { redirect_to(@register_play, :notice => 'Register play was successfully created.') }
        format.xml  { render :xml => @register_play, :status => :created, :location => @register_play }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @register_play.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /register_plays/1
  # PUT /register_plays/1.xml
  def update
    @register_play = RegisterPlay.find(params[:id])

    respond_to do |format|
      if @register_play.update_attributes(params[:register_play])
        format.html { redirect_to(@register_play, :notice => 'Register play was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @register_play.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /register_plays/1
  # DELETE /register_plays/1.xml
  def destroy
    @register_play = RegisterPlay.find(params[:id])
    @register_play.destroy

    respond_to do |format|
      format.html { redirect_to(register_plays_url) }
      format.xml  { head :ok }
    end
  end
end
