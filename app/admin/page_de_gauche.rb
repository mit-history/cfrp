ActiveAdmin.register PageDeGauche do

  menu parent: "Registres", priority: 5

  index :title => 'Pages De Gauche' do
    column :id
    column :category
    actions
  end

end
