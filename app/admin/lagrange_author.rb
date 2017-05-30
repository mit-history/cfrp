ActiveAdmin.register LagrangeAuthor do
  menu parent: "Lagrange", priority: 1

	preserve_default_filters!
  remove_filter :lagrange_doc_authors
  remove_filter :lagrange_docs  
end
