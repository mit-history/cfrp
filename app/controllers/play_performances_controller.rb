class PlayPerformancesController < ActionController::Base

  def index
    filter = params[:filter] || {}

    if stale?(Register.facet_cache_key)
      # (1) Rails JSON rendering is quite slow
      # (2) Heroku memory requirements forbid loading Register.all with ActiveRecord
      # Combined solution: retrieve shell objects with only necessary columns
      render :json => Register.refine(filter).select([:id, :date])
      # (another option: render ..., :only => [:id, :date])
      # See the example data-essays page for alternatives to serve large JSON feeds.
    end
  end

end
