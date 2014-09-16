ActiveAdmin.register RegisterImage do
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
    # TODO: investigate missing images.
    image_tag(register_image.image.url(:thumb))
  end
end
