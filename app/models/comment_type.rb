# == Schema Information
# Schema version: 20100927135806
#
# Table name: comment_types
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CommentType < ActiveRecord::Base
end
