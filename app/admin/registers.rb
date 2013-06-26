ActiveAdmin.register Register do
  # belongs_to :register_period
  # belongs_to :verification_state

  config.per_page = 12
    
  scope :all, :default => true
  scope :unverified do |registers|
    Register.unverified
  end

  scope :unentered do |registers|
    Register.unentered
  end

  filter :date
  # filter :month, :as => :select, :collection => (1..12)
  filter :weekday
  filter :season
  filter :register_num
  # filter :payment_notes
  # filter :page_text
  # filter :total_receipts_recorded_l
  # filter :total_receipts_recorded_s
  filter :representation
  filter :signatory
  # filter :misc_notes
  # filter :for_editor_notes
  filter :ouverture
  filter :cloture
  filter :register_period_period, :as => :select 
  filter :verification_state_id
  # filter :register_plays_attributes
  # filter :ticket_sales_attributes
  # filter :rep_privacy_list
  # filter :rep_group_list
  filter :irregular_receipts_name
  # filter :register_images
  # filter :created_at
  # filter :updated_at

  # filter :taggings_tag_name, :as => :check_boxes, :collection => proc { Activity.tag_counts.map{|t| t.name} }

  # batch_action :destroy do |selection|
  #   Activity.find(selection).each do |activity|
  #     activity.destroy
  #   end
  # end

  index do
    selectable_column
    # column 'Formulaire de saisie' do |register|
    #   link_to(image_tag("/#{register.register_images[0].filepath}", width: "50"), "/registers/#{register.id}/edit", target: "_blank")
    #   # link_to("Formulaire de saisie", "/registers/#{register.id}/edit", target: "_blank")
    # end
    column :id
    column :date
    column :weekday
    column :season
    actions :defaults => false do |register|
      # link_to("View", "/registers/#{register.id}/edit", target: "_blank")
      link_to("Formulaire de saisie", "/registers/#{register.id}/edit", target: "_blank")
    end
  end

  index :as => :grid, :columns => 4 do |register|
    link_to(image_tag("/#{register.register_images[0].filepath}", width: "200"), "/registers/#{register.id}/edit", target: "_blank")
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
        f.input :date
        f.input :weekday
        f.input :season
        f.input :register_num
        f.input :payment_notes
        f.input :page_text
        f.input :total_receipts_recorded_l
        f.input :total_receipts_recorded_s
        f.input :representation
        f.input :signatory
        f.input :misc_notes
        f.input :for_editor_notes
        f.input :ouverture
        f.input :cloture
        f.input :register_period_id
        f.input :verification_state_id
        f.input :irregular_receipts_name
      end
      f.actions
    end
end
