ActiveAdmin.register Register do
  menu false
  # menu :priority => 1
  config.per_page = 20
  actions :all, :except => [:new]

  config = Cfrp::Application.config

  scope :all, :default => true
  scope :unentered
  scope :unverified
  scope :probleme
  scope :verified

  filter :id
  filter :date
  filter :season, :label => "Saison", :as => :select, :collection => proc { Register.order(:season).all.map {|r| r.season}.uniq }
  filter :register_plays_play_title, :label => "Titre de Piece", :as => :select, :collection => proc { Play.order(:title).all.map {|p| p.title}.uniq }
  filter :register_plays_play_author, :label => "Auteur de Piece", :as => :select, :collection => proc { Play.order(:author).all.map{|p| p.author}.uniq }
  
  config.batch_actions = true
  # batch_action :destroy, false

  batch_action :destroy, :if => proc { current_user.has_role?(:super_admin) }, :confirm => "Are you sure you want to delete all of these?" do |selection|
    session[:return_to] ||= request.referer
    Register.find(selection).each do |register|
      register.destroy
    end
    redirect_to session.delete(:return_to), alert: "Registers deleted"
  end

  batch_action :unentered do |selection|
    session[:return_to] ||= request.referer
    Register.find(selection).each do |register|
      register.verification_state_id = 5
      register.save
    end
    # Rails.logger.info "Unentered"
    redirect_to session.delete(:return_to), alert: "Registers marked as unentered"
  end

  batch_action :unverified do |selection|
    session[:return_to] ||= request.referer
    Register.find(selection).each do |register|
      register.verification_state_id = 2
      register.save
    end
    redirect_to session.delete(:return_to), alert: "Registers marked as unverified"
  end

  batch_action :verified do |selection|
    session[:return_to] ||= request.referer
    Register.find(selection).each do |register|
      register.verification_state_id = 1
      register.save
    end
    redirect_to session.delete(:return_to), alert: "Registers marked as verified"
  end

  batch_action :probleme do |selection|
    session[:return_to] ||= request.referer
    Register.find(selection).each do |register|
      register.verification_state_id = 6
      register.save
    end
    redirect_to session.delete(:return_to), alert: "Registers marked as probleme"
  end
      
      
  controller do
    def scoped_collection
      resource_class.includes(:register_images)
    end

    before_filter :only => [:index] do
      if params['commit'].blank?
         #country_contains or country_eq .. or depending of your filter type
         params['q'] = {:date_gte => '1600-01-01', :date_lte => '1800-01-01'} 
      end
    end
  end
    
  index do
    selectable_column
    column :id

    # column 'Image' do |register|
    #   link_to(image_tag("/#{register.register_images[0].filepath}", width: "100"), "/registers/#{register.id}/edit", target: "_blank")
    #   # link_to("Formulaire de saisie", "/registers/#{register.id}/edit", target: "_blank")
    # end

    column "Date", :date
    column "Saison", :season
    column "Status", :verification_state

    column "" do |resource|
      links = ''.html_safe
      if current_user.has_role?(:super_admin)
        links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
        links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
        links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      end
      links += link_to("Formulaire de saisie", "/registers/#{resource.id}/edit", target: "_blank")
      links
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
