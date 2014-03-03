ActiveAdmin.register PageDeGauche do

  menu false

  index :title => 'Pages De Gauche' do
    column :id
    column :category
    default_actions
  end

end
