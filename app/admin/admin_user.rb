ActiveAdmin.register User do     
  menu false

  filter :assignments_role_name, :label => "Roles", :as => :check_boxes, :collection => proc { Role.order(:name).all.map {|r| r.name}.uniq }

  config.batch_actions = true
  batch_action :destroy, false

  batch_action :approve do |selection|
    User.find(selection).each do |user|
      user.set_roles = ['approved']
    end
    redirect_to :back, :notice => "User approved!"
  end

  batch_action :editor do |selection|
    User.find(selection).each do |user|
      user.set_roles = ['editor']
    end
    redirect_to :back, :notice => "Editor created!"
  end

  batch_action :verifier do |selection|
    User.find(selection).each do |user|
      user.set_roles = ['verifier']
    end
    redirect_to :back, :notice => "Verifier created!"
  end

  batch_action :admin do |selection|
    User.find(selection).each do |user|
      user.set_roles = ['admin']
    end
    redirect_to :back, :notice => "Admins created!"
  end

  index do |user|                            
    selectable_column
    id_column

    column "First name", :first_name
    column "Last name", :last_name

    column :email                     

    column "Roles", :roles_to_s, :sortable => false

    column :last_sign_in_at           
    column :sign_in_count             

    default_actions                   
  end                                 

  show do |user|
    attributes_table do
      row :first_name
      row :last_name
      # row :rep_group_list
    end
    active_admin_comments
  end

  form do |f|                         
    f.inputs "Details" do
      f.input :first_name, :as => :string
      f.input :last_name, :as => :string
      f.input :email, :as => :string
      f.input :roles,
        :label => "Add/remove existing roles", 
        :as => :check_boxes
    end
    f.buttons
  end                                 
end                                   
