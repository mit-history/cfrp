ActiveAdmin.register PageDeGauche do

  menu false

  index :title => 'Pages De Gauche' do
    column :id
    column :category
    actions
  end

end
