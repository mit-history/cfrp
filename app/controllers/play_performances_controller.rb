class PlayPerformancesController < ActionController::Base
  
  def index
    filter = params[:filter] || {}
    limit  = params[:limit]  || false
    offset = params[:offset] || false

    if stale?(Register.facet_cache_key)
      render :json => Register.refine(filter).joins(:register_plays).offset(offset).limit(limit)
    end
  end
end
