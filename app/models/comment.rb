# == Schema Information
# Schema version: 20100927135806
#
# Table name: comments
#
#  id              :integer         not null, primary key
#  name            :string(255)
#  value           :text
#  register_id     :integer
#  comment_type_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class Comment < ActiveRecord::Base
end
