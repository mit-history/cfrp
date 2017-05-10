ActiveAdmin.register Person do
  # menu false

  scope :all, :default => true

  # filter :birthyear 
  # filter :deathyear 
  filter :plays, 
    label: 'Oeuvre',
    :as => :select,
    :collection => Play.expert_validated

  index :title => 'Personnes' do
    column "ID", :id
    column "ID Externe", :ext_id
    # column 'Image' do |person|
    #   if person.person_depictions.any?
    #     image_tag(person.person_depictions.first.url, width: "100")
    #   end
    # end
    column "Date de Naissance", :birthyear
    column "Date de Mort", :deathyear
    column "Prenom", :first_name
    column "Nom de Famille", :last_name
    column :pref_label
    column :orig_label
    column "Pseudonyme", :pseudonym
    column "Notes BnF", :bnf_notes
    actions
  end
end
