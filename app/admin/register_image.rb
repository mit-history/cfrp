ActiveAdmin.register RegisterImage do
  menu parent: "Registres", priority: 4

  config.filters = false

  index do
    selectable_column
    column :id
    column :register_id
    column :image_file_name
    column :image_content_type
    column :image_file_size
    column :image_updated_at
    column :orientation
  end

  index :as => :grid, :columns => 4 do |register_image|
    # TODO: investigate missing images again.
    image_tag(register_image.image.url(:thumb))
  end
end
