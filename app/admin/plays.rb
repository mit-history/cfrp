ActiveAdmin.register Play do

  menu parent: "Pieces", priority: 1

  config.per_page = 20
  actions :all#, :except => [:new]

  config = Cfrp::Application.config

  scope :expert_validated, :default => true
  scope :tragédie
  scope :comédie
  scope :all

  filter :title
  filter :genre
  filter :expert_validated
  filter :person, 
    label: 'Auteur',
    :as => :select,
    :collection => proc { 
      Person.is_author.order(:last_name).map{|p| [p.name, p.id] } 
  }

  config.batch_actions = true
  # batch_action :destroy, false

  index do
    selectable_column
    column :id
    column "Auteur" do |play|
      link_to play.person.name, admin_person_path(play.person)
    end

    column :title
    column :genre
    column :acts
    column :prose_vers
    column :prologue
    column :musique_danse_machine
    column :updated_at
    column :expert_validated
    actions
  end

  # sidebar "Performance Dates", only: :show do
  #   table_for play.registers do
  #     column :date
  #   end
  # end

  # show do


  form do |f|
      f.inputs "Auteur", for: [:authorship, f.object.authorship || Authorship.new] do |author_form|
        author_form.input :person, :as => :select, :collection => Person.is_author.order(:last_name).map{|p| [p.name, p.ext_id]}, label: "Auteur"
      end

      f.inputs "Details", :multipart => true do
        f.input :author, input_html: { disabled: true }, label: "Auteur (reference seulement; veuillez selectionner au-dessus)"
        f.input :title
        f.input :genre
        f.input :acts
        f.input :prose_vers
        f.input :prologue
        f.input :musique_danse_machine
        f.input :alternative_title
        f.input :url
        f.input :date_de_creation, :as => :string, :placeholder => "1700-01-01"
        f.input :expert_validated
      end
      f.actions
    end
end
