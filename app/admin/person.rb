ActiveAdmin.register Person do

  menu false

  scope :all, :default => true
  # scope :probleme # actors who are associated
  # scope :verified


  index :title => 'Acteurs et actrices' do
    column :id
    column :pseudonym
    column :first_name
    column :last_name
    default_actions
  end

end
