# == Schema Information
#
# Table name: registers
#
#  id                        :integer         not null, primary key
#  date                      :date
#  weekday                   :string(255)
#  season                    :string(255)
#  register_num              :integer
#  payment_notes             :text
#  page_text                 :text
#  total_receipts_recorded_l :integer
#  total_receipts_recorded_s :integer
#  total_receipts_recorded_d :integer
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
#  irregular_receipts_name   :string(255)
#

# -*- coding: utf-8 -*-

class Register < ActiveRecord::Base

  has_many :lhp_category_assignments
  has_many :page_de_gauches, through: :lhp_category_assignments
  accepts_nested_attributes_for :lhp_category_assignments, reject_if: proc { |attributes| attributes['page_de_gauche_id'].blank? }, allow_destroy: true

  # default_scope order("date ASC")
  attr_accessible :date, :weekday,
    :date_of_left_page_info, :season, :register_num,
    :payment_notes, :page_text,
    :total_receipts_recorded_l, :total_receipts_recorded_s, :total_receipts_recorded_d,
    :representation, :signatory, :misc_notes, :for_editor_notes, :ouverture,
    :cloture, :register_period_id, :verification_state_id,
    :register_plays_attributes, :ticket_sales_attributes,
    :rep_privacy_list, :rep_group_list, :register_images,
    :irregular_receipts_name,
    :irregular_receipts_name_2,
    :irregular_receipts_name_3,
    :irregular_receipts_name_4,
    :irregular_receipts_name_5,
    :irregular_receipts_name_6,
    :irregular_receipts_name_7,
    :irregular_receipts_name_8,
    :irregular_receipts_name_9,
    :irregular_receipts_name_10,
    :lhp_category_assignments_attributes


  # Repertoire Groups
  acts_as_taggable_on :rep_privacy, :rep_group

  has_many :ticket_sales
  has_many :register_images

  belongs_to :register_period
  belongs_to :verification_state

  has_one :register_contributor
  has_one :user, :through => :register_contributor

  # Association through plays
  has_many :register_plays
  has_many :plays, :through => :register_plays

  accepts_nested_attributes_for :plays, :ticket_sales
  accepts_nested_attributes_for :register_images, :allow_destroy => true
  accepts_nested_attributes_for :register_plays, :allow_destroy => true
  # accepts_nested_attributes_for :page_de_gauches, :allow_destroy => true

  validates :date, presence: true

  scope :verified, where(:verification_state_id => 1).order("id asc")
  scope :unverified, where(:verification_state_id => 2).order("id asc")
  scope :unentered, where(:verification_state_id => 5).order("id asc")
  scope :probleme, where(:verification_state_id => 6).order("id asc")

  scope :has_old_actor, includes(:register_plays).where("register_plays.newactor <> ''")

  scope :image_count, ->(count) { where("register_images_count = ?", count) }
  scope :two_images, image_count(2)
  scope :one_image, image_count(1)
  scope :no_image, image_count(0)

  def self.unique_seasons
    order(:season).uniq(:season).pluck(:season)
  end

  def self.unique_dates
    order(:date).uniq(:date).pluck(:date)
  end

  def build_lhp_category_assignments=(attrs)
    new_lhp_cat_ass = LhpCategoryAssignment.find(attrs[:register_id])
    unless new_lhp_cat_ass.nil?
      self.lhp_category_assignments = new_lhp_cat_ass
    end
  end

  def previous
    Register.where(season: self.season, id: self.id - 1).first
  end

  def next
    Register.where(season: self.season, id: self.id + 1).first
  end

  def volume_number
    image_filepath = self.register_images[1].filepath
    volume_number = /M119_02_R(\d+)/.match(image_filepath)[1]
  end

  def rhp_image_number
    image_filepath = self.register_images[0].filepath
    rhp_image_number = /M119_02_R(\d+)\/M119_02_R(\d+)_(\d+)([rv]).jpg/.match(image_filepath)[3]
  end

  def self.play_authors

  end

  def ticket_sales_attributes=params
    params.each do |ts|
      begin
        real_ts = TicketSale.update(ts[1]['id'], ts[1].except('id'))
      rescue ActiveRecord::RecordNotFound
        self.ticket_sales << TicketSale.new(ts[1].except('id'))
      end
    end
  end

  # Hack, or at least should be a helper?
  # In the end, this is a UI problem...how to solve best?
  def next_unentered_register
    Register.order('id')
      .where(:season => self.season)
      .where("id > ?", self.id).detect do |r|
      r.verification_state.name == 'pas saisie'
    end
  end

  def next_unverified_register
    Register.order('id')
      .where(:season => self.season)
      .where("id > ?", self.id).detect do |r|
      r.verification_state.name == 'pas verifie'
    end
  end

  def next_verified_register
    Register.order('id')
      .where(:season => self.season)
      .where("id > ?", self.id).detect do |r|
      r.verification_state.name == 'verifie'
    end
  end

  def next_probleme_register
    Register.order('id')
      .where(:season => self.season)
      .where("id > ?", self.id).detect do |r|
      r.verification_state.name == 'probleme'
    end
  end
end
