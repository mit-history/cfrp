ActiveAdmin.register Person do

  menu false

  index :title => 'Acteurs et actrices' do
    column :id
    column :pseudonym
    column :first_name
    column :last_name
    default_actions
  end

end
