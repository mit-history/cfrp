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
