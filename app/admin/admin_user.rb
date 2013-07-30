ActiveAdmin.register User do     
  menu false
  index do                            
    column :id           #   :string(255)
    column :last_name           #   :string(255)
    column :first_name         #    :string(255)
    column :shortname            #  :string(255)
    column :email                     
    column :institution      #      :string(255)
    column :last_sign_in_at           
    column :sign_in_count             

    default_actions                   
  end                                 

  filter :email                       

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end                                 
end                                   
