ActiveAdmin.register PersonSameAs do
  menu parent: "Personnes", priority: 6
  filter :person, 
    label: 'Personne',
    :as => :select,
    :collection => proc { 
      Person.is_author.map{|p| [p.name_with_honorific, p.id] }
  }
end
