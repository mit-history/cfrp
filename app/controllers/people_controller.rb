class PeopleController < ApplicationController
  include Repertoire::Faceting::Controller

	def index
		@search = params[:search] || ''
	end

	def show
		@person = person.find(params[:id])
	end

	def new
		@person = person.new
	end

	def edit
		@person = person.find(params[:id])
		@people = person.all
	end

	def create
		@person = person.new(params[:person])
	end

	def update
		@person = person.find(params[:id])
		@person.update_attributes!(params[:person])
		redirect_to :action => "edit", :id => @person.id, :notice => 'person was successfully updated.'
	end

	def destroy
		@person = person.find(params[:id])
		@person.destroy
		redirect_to :action => "index", :notice => 'person was successfully updated.'
	end

	def import
		Person.import(params[:file])
		redirect_to root_url, notice: "people imported."
	end

  protected
  def base
    Person
  end

end
