ActiveAdmin.register LagrangeDoc do
  menu parent: "Lagrange", priority: 2
  filter :title
  filter :title2
  filter :subtitle
  filter :etype
  filter :imgref
  filter :imgurl
  filter :url
  filter :lagrange_author, :collection => proc { LagrangeAuthor.all.map { |a| [a.computedform, a.id] } }, :as => :select

  index do
    column :id
    column "Auteur", :lagrange_author
    column :etype
    column :title
    column :title2
    column :subtitle
    column :imgref
    column :imgurl
    column :url
  end
end
