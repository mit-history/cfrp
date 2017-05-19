ActiveAdmin.register PersonDepiction do
  filter :person, 
    label: 'Personne',
    :as => :select,
    :collection => proc { 
      Person.is_author.map{|p| [p.name_with_honorific, p.id] }
  }


  index do
    selectable_column
    column :id
    column "Auteur" do |depiction|
	  	link_to(depiction.person.name, admin_person_path(depiction.person))
    end
    column 'Image' do |depiction|
  		image_tag(depiction.url, width: "200")
    end
  end
end
