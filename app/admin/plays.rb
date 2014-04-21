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
end
