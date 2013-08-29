# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  encrypted_password     :string(255)     default(""), not null
#  password_salt          :string(255)     default(""), not null
#  reset_password_token   :string(255)
#  remember_token         :string(255)
#  remember_created_at    :datetime
#  sign_in_count          :integer         default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  shortname              :string(255)
#  last_name              :string(255)
#  first_name             :string(255)
#  bio                    :text
#  institution            :string(255)
#  institution_code       :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  reset_password_sent_at :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, # :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Repertoire Groups
  acts_as_role_user
  acts_as_taggable_on :rep_privacy, :rep_group

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :shortname, :last_name, :first_name,
                  :password_confirmation, :remember_me, :rep_privacy_list, :rep_group_list, :role_ids
  accepts_nested_attributes_for :assignments

  belongs_to :register_contributor

  alias :devise_valid_password? :valid_password?

  def roles_to_s
    self.roles.map(&:name).join(", ")
  end

  # Moving from (very) old Merb sha1 password scheme to Devise w/bcrypt.
  # These two stack overflow posts were extremely helpful:
  # http://stackoverflow.com/questions/11037864/bcrypterrorsinvalidhash-when-trying-to-sign-in
  # http://stackoverflow.com/questions/6113375/converting-existing-password-hash-to-devise
  # And this is where I found the old Merb authentication code so I could get this working:
  # https://github.com/wycats/merb/blob/master/merb-auth/merb-auth-more/lib/merb-auth-more/mixins/salted_user.rb
  def valid_password?(password)
    begin
      super(password)
    rescue BCrypt::Errors::InvalidHash
      sha1_password = Digest::SHA1.hexdigest("--#{password_salt}--#{password}--")
      return false unless sha1_password == encrypted_password
      logger.info "User #{email} is using the old password hashing method, updating attribute."
      self.password = password # = BCrypt::Password.create(sha1_password)
      true
    end
  end
end
