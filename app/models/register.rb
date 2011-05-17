# == Schema Information
# Schema version: 20100927135806
#
# Table name: registers
#
#  id                        :integer         not null, primary key
#  date                      :datetime
#  weekday                   :string(255)
#  season                    :string(255)
#  register_num              :integer
#  payment_notes             :text
#  date_flag                 :boolean
#  season_flag               :boolean
#  regnum_flag               :boolean
#  totalreceipts_flag        :boolean
#  payment_notes_flag        :boolean
#  page_text                 :text
#  page_text_flag            :boolean
#  total_receipts_recorded_l :integer
#  total_receipts_recorded_s :integer
#  representation            :integer
#  signatory                 :string(255)
#  signatory_flag            :boolean
#  rep_flag                  :boolean
#  misc_notes                :text
#  misc_notes_flag           :boolean
#  for_editor_notes          :text
#  ouverture                 :boolean
#  ouverture_flag            :boolean
#  cloture                   :boolean
#  cloture_flag              :boolean
#  created_at                :datetime
#  updated_at                :datetime
#  register_image_id         :integer
#  register_period_id        :integer
#

class Register < ActiveRecord::Base
  include Repertoire::Faceting::Model

  belongs_to :register_image

  has_many :ticket_sales

  # Association through plays
  has_many :register_plays
  has_many :plays, :through => :register_plays

  accepts_nested_attributes_for :register_plays
  accepts_nested_attributes_for :plays

  facet :season
  facet :weekday
  facet :total_receipts_recorded_l
  facet :newactor, joins(:register_plays)
  facet :title, joins(:register_plays).joins(:plays)
  facet :author, joins(:register_plays).joins(:plays)

# what
#  facet :total_receipts, Table(:registers).project("(total_receipts_recorded_l + total_receipts_recorded_s) as total_receipts")
end
