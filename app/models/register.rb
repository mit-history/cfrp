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

  include Repertoire::Faceting::Model

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
    :register_plays_attributes, :ticket_sales_attributes, :register_images_attributes,
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

  facet :season, order(:season)
  # Thank you: http://postgresql.1045698.n5.nabble.com/GENERAL-sort-character-data-in-arbitrary-order-td1855410.html
  facet :weekday, order("weekday = 'Dimanche'").order("weekday = 'Samedi'").order("weekday = 'Vendredi'").order("weekday = 'Jeudi'").order("weekday = 'Mercredi'").order("weekday = 'Mardi'").order("weekday = 'Lundi'")
  facet :title1, joins(:plays, :register_plays).where('register_plays.ordering = 1').group('plays.title')
  facet :title2, joins(:plays, :register_plays).where('register_plays.ordering = 2').group('plays.title')
  facet :author1, joins(:plays, :register_plays).where('register_plays.ordering = 1').group('plays.author')
  facet :author2, joins(:plays, :register_plays).where('register_plays.ordering = 2').group('plays.author')
  facet :genre1, joins(:plays, :register_plays).where('register_plays.ordering = 1').group('plays.genre')
  facet :genre2, joins(:plays, :register_plays).where('register_plays.ordering = 2').group('plays.genre')
  facet :total_receipts, group("'₤ ' || bucket(total_receipts_recorded_l, 100, 5, 'Inconnu')").order(:total_receipts)

  # Listing seating category ids directly in code is obviously a sub-par approach... however, (a) while the investigators' interpretations
  # of periods and seating categories is still under transition, I decided it was best to avoid changing the database or adding new columns;
  # (b) the kinds of aggregations necessary for measures like receipts are not possible with a faceted browser, so best to make it easy to
  # back and adopt a real multidimensional indexer.

  # see the appropriate migration for definitions of amalgamated sales and bucket
  facet :parterre_receipts,      joins('JOIN amalgamated_sales ON (registers.id = register_id)').where("section = 'parterre'").group("'₤ ' || bucket(receipts, 100, 5, 'Inconnu')").order(:parterre_receipts)
  facet :premiere_loge_receipts, joins('JOIN amalgamated_sales ON (registers.id = register_id)').where("section = 'premiere-loge'").group("'₤ ' || bucket(receipts, 100, 5, 'Inconnu')").order(:premiere_loge_receipts)


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
    if (!self.recto_image.nil?)
      image_filename = self.recto_image.image_file_name
      volume_number = /M119_02_R(\d+)/.match(image_filename)[1]
    else
      volume_number = nil
    end
    return volume_number
  end

  def rhp_image_number
    if (!self.recto_image.nil?)
      image_filename = self.recto_image.image_file_name
      if (/M119_02_R(\d+)_(\d+)([rv])?.jpg/.match(image_filename)[2])
        rhp_image_number = /M119_02_R(\d+)_(\d+)([rv])?.jpg/.match(image_filename)[2]
      else
        rhp_image_number = nil
      end
    end
    return rhp_image_number
  end

  def recto_image
    oriented_image = self.register_images.where(orientation: 'recto').first
    if (!oriented_image.nil?)
      recto_image = oriented_image
    else
      my_first_image = self.register_images[0]
      if (!my_first_image.nil? && my_first_image.rv_flag == 'r')
        recto_image = my_first_image
      else
        recto_image = nil
      end
    end
    return recto_image
  end

  def left_image
    oriented_image = self.register_images.where(orientation: 'left').first
    if (!oriented_image.nil?)
      left_image = oriented_image
    elsif (!self.previous.nil?)
      last_register_verso = self.previous.verso_image
      # binding.pry
      if (!last_register_verso.nil? && !last_register_verso.rv_flag.nil? && last_register_verso.rv_flag == 'v')
        left_image = last_register_verso
      else
        left_image = nil
      end
    else
      left_image = nil
    end
    return left_image
  end

  def verso_image
    oriented_image = self.register_images.where(orientation: 'verso').first
    if (!oriented_image.nil?)
      verso_image = oriented_image
    else
      my_second_image = self.register_images[1]
      if (!my_second_image.nil? && my_second_image.rv_flag == 'v')
        verso_image = my_second_image
      else
        verso_image = nil
      end
    end
    verso_image
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
