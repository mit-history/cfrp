# == Schema Information
#
# Table name: registers
#
#  id                        :integer         not null, primary key
#  date                      :datetime
#  weekday                   :string(255)
#  season                    :string(255)
#  register_num              :integer
#  payment_notes             :text
#  page_text                 :text
#  total_receipts_recorded_l :integer
#  total_receipts_recorded_s :integer
#  representation            :integer
#  signatory                 :string(255)
#  misc_notes                :text
#  for_editor_notes          :text
#  ouverture                 :boolean
#  cloture                   :boolean
#  created_at                :datetime
#  updated_at                :datetime
#  register_image_id         :integer
#  register_period_id        :integer
#  verification_state_id     :integer
#

class Register < ActiveRecord::Base
  include Repertoire::Faceting::Model

  attr_accessible :date, :weekday, :season, :register_num, :payment_notes, :page_text, :total_receipts_recorded_l, :total_receipts_recorded_s, :representation, :signatory, :misc_notes, :for_editor_notes, :ouverture, :cloture, :register_image_id, :register_period_id, :verification_state_id, :register_plays_attributes, :ticket_sales_attributes

  has_many :ticket_sales

  belongs_to :register_image
  belongs_to :verification_state

  has_one :register_contributor
  has_one :user, :through => :register_contributor

  # Association through plays
  has_many :register_plays
  has_many :plays, :through => :register_plays

  accepts_nested_attributes_for :register_plays, :plays, :ticket_sales

#  def register_plays_attributes params
#    print params.inspect
#  end

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
