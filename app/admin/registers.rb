ActiveAdmin.register Register do
  config.per_page = 12

  scope :all, :default => true

  filter :date
  filter :weekday
  filter :season
  filter :register_num
  filter :payment_notes
  filter :page_text
  filter :total_receipts_recorded_l
  filter :total_receipts_recorded_s
  filter :representation
  filter :signatory
  filter :misc_notes
  filter :for_editor_notes
  filter :ouverture
  filter :cloture
  filter :register_period_id
  filter :verification_state_id
  filter :register_plays_attributes
  filter :ticket_sales_attributes
  filter :rep_privacy_list
  filter :rep_group_list
  filter :irregular_receipts_name
  filter :register_images
  filter :created_at
  filter :updated_at

  # filter :taggings_tag_name, :as => :check_boxes, :collection => proc { Activity.tag_counts.map{|t| t.name} }

  # batch_action :destroy do |selection|
  #   Activity.find(selection).each do |activity|
  #     activity.destroy
  #   end
  # end

  index do
    selectable_column
    column 'Thumb' do |register|
      link_to(image_tag("/#{register.register_images[0].filepath}", width: "100"), "/#{register.register_images[0].filepath}", target: "_blank")
    end
    column :id
    column :date
    column :weekday
    column :season
    default_actions
  end

  index :as => :grid, :columns => 4 do |register|
    image_tag("/#{register.register_images[0].filepath}", width: "300")
  end
    
  show do |register|
    attributes_table do
      row :date
      row :weekday
      row :season
      row :register_num
      row :payment_notes
      row :page_text
      row :total_receipts_recorded_l
      row :total_receipts_recorded_s
      row :representation
      row :signatory
      row :misc_notes
      row :for_editor_notes
      row :ouverture
      row :cloture
      row :register_period_id
      row :verification_state_id
      row :rep_privacy_list
      row :rep_group_list
      row :irregular_receipts_name
      row :register_images
      row :created_at
      row :updated_at
    end
    active_admin_comments
  end
      
  form do |f|
      f.inputs "Details", :multipart => true do
        f.input :date, :as => :date
        f.input :weekday, :as => :string
        f.input :season, :as => :string
        # f.input :tag_list, :label => "STEM Categories",
        #                    :as => :select,
        #                    :multiple => :true,
        #                    :collection => ActsAsTaggableOn::Tag.all.map(&:name)
      end

      f.buttons
    end
end
