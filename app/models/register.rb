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

  has_many :ticket_sales

  belongs_to :register_image
  belongs_to :verification_state

  has_one :register_contributor
  has_one :user, :through => :register_contributor

  # Association through plays
  has_many :register_plays
  has_many :plays, :through => :register_plays

  accepts_nested_attributes_for :register_plays
  accepts_nested_attributes_for :plays

  #######################################################
  # FACETING
  facet :season, order(:season)

  # Thank you: http://postgresql.1045698.n5.nabble.com/GENERAL-sort-character-data-in-arbitrary-order-td1855410.html
  facet :weekday, order("weekday = 'Dimanche'").order("weekday = 'Samedi'").order("weekday = 'Vendredi'").order("weekday = 'Jeudi'").order("weekday = 'Mercredi'").order("weekday = 'Mardi'").order("weekday = 'Lundi'")

  facet :total_receipts_recorded_l, order('total_receipts_recorded_l DESC')
  # facet :total_receipts_recorded_l, group('total_receipts_recorded_l HAVING total_receipts_recorded_l > 100 AND total_receipts_recorded_l < 500')

  #     SELECT users.first_name, users.last_name
  #       FROM register_contributors
  # INNER JOIN registers ON registers.id = register_contributors.register_id
  # INNER JOIN users ON users.id = register_contributors.user_id
  #   GROUP BY users.first_name, users.last_name;

  facet :register_contributor_name, joins('INNER JOIN register_contributors ON registers.id = register_contributors.register_id').joins('INNER JOIN users ON users.id = register_contributors.user_id').group("users.first_name || ' ' || users.last_name")

  facet :verification_state, joins(:verification_state).group('verification_states.name')

  facet :newactor, joins(:register_plays)
  facet :title1, joins(:plays).joins(:register_plays).where('register_plays.ordering = 0').group('plays.title')
  facet :title2, joins(:plays).joins(:register_plays).where('register_plays.ordering = 1').group('plays.title')
  facet :author1, joins(:plays).joins(:register_plays).where('register_plays.ordering = 0').group('plays.author')
  facet :author2, joins(:plays).joins(:register_plays).where('register_plays.ordering = 1').group('plays.author')

# what
#  facet :total_receipts, Table(:register).project("(total_receipts_recorded_l + total_receipts_recorded_s) as total_receipts")
end
