# == Schema Information
# Schema version: 20100927135806
#
# Table name: page_text_templates
#
#  id            :integer         not null, primary key
#  template_text :text
#  created_at    :datetime
#  updated_at    :datetime
#

class PageTextTemplate < ActiveRecord::Base
end
