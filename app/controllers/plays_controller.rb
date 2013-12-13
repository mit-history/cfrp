class PlaysController < ApplicationController
	def index
		@search = params[:search] || ''
	end

	def show
		@play = play.find(params[:id])
	end

	def new
		@play = play.new
	end

	def edit
		@play = play.find(params[:id])
		@plays = Play.all
	end

	def create
		@play = play.new(params[:play])
	end

	def update
		@play = play.find(params[:id])
		@play.update_attributes!(params[:play])
		redirect_to :action => "edit", :id => @play.id, :notice => 'play was successfully updated.'
	end

	def destroy
		@play = play.find(params[:id])
		@play.destroy
		redirect_to :action => "index", :notice => 'play was successfully updated.'
	end

	def import
		Play.import(params[:file])
		redirect_to root_url, notice: "Plays imported."
	end
end
