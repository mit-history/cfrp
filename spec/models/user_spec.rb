# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  let(:first_name) { "Fake First Name" }
  let(:last_name) { "Fake Last Name" }
  let(:password)  { "p4ssw0rd" }
  let(:email)     { "fake@fakeaddress.com" }

  it "should allow you to set first name and last name" do
    @user = User.new( first_name: first_name,
                      last_name: last_name,
                      password: password,
                      email: email )
    @user.save
    @user.first_name.should == first_name
    @user.last_name.should == last_name
  end
end

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

