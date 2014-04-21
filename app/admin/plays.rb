ActiveAdmin.register Play do

  menu false

  config.per_page = 20
  actions :all#, :except => [:new]

  config = Cfrp::Application.config

  scope :all, :default => true
  scope :tragédie
  scope :comédie
  scope :expert_validated

  filter :author
  filter :title
  filter :genre
  filter :expert_validated

  config.batch_actions = true
  # batch_action :destroy, false

  index do
    selectable_column
    column :id
    column :author
    column :title
    column :genre
    column :acts
    column :prose_vers
    column :prologue
    column :musique_danse_machine
    column :updated_at
    column :expert_validated
    default_actions
  end


  form do |f|
      f.inputs "Details", :multipart => true do
        f.input :author
        f.input :title
        f.input :genre
        f.input :acts
        f.input :prose_vers
        f.input :prologue
        f.input :musique_danse_machine
        f.input :alternative_title
        f.input :url
        f.input :date_de_creation, :as => :string, :placeholder => "1700-01-01"
      end
      f.actions
    end

end
