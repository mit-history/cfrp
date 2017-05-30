ActiveAdmin.register SeatingCategory do
  menu false

  config.filters = false

  config.batch_actions = true
  batch_action :destroy, false

  batch_action :mark_loge do |selection|
    SeatingCategory.find(selection).each do |category|
      category.loge = true
      category.save!
    end
    redirect_to :back, :notice => "Category marked loge."
  end

end
