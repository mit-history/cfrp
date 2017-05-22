# t.string   "first_name"
# t.string   "last_name"
# t.string   "full_name"
# t.string   "pseudonym"
# t.string   "honorific"
# t.string   "url"
# t.datetime "created_at",              :null => false
# t.datetime "updated_at",              :null => false
# t.string   "alias"
# t.string   "societaire_pensionnaire"
# t.string   "dates"
# t.integer  "birthyear"
# t.integer  "deathyear"
# t.string   "pref_label"
# t.string   "orig_label"
# t.text     "bnf_notes"
# t.integer  "ext_id"

class Person < ActiveRecord::Base
  include Repertoire::Faceting::Model

  facet :pseudonym
  facet :alias
  facet :last_name
  facet :honorific

  attr_accessible :first_name, :full_name, :honorific,
  :last_name, :pseudonym, :url, :alias, :societaire_pensionnaire, :dates,
  :birthyear, :deathyear, :pref_label, :orig_label, :bnf_notes, :ext_id, 
  :is_author, :is_actor

  has_many :authorships, :foreign_key => :ext_id, :primary_key => :ext_id
  has_many :plays, :through => :authorships

  has_many :person_altlabels, :foreign_key => :ext_id, :primary_key => :ext_id
  has_many :person_depictions, :foreign_key => :ext_id, :primary_key => :ext_id
  has_many :person_same_as, :foreign_key => :ext_id, :primary_key => :ext_id

  scope :is_author, where("is_author is true")
  scope :is_actor, where("is_actor is true")
  scope :with_name, !name.blank?
  # validates_presence_of :full_name

  def name
    if !last_name.blank?
      name = "#{first_name} #{last_name}"
    elsif !pref_label.blank?
      name = pref_label
    elsif !orig_label.blank?
      name = orig_label
    elsif !full_name.blank?
      name = full_name
    elsif !pseudonym.blank?
      name = pseudonym
    end
    return name
  end

  def name_with_honorific
    if name.blank?
      return "[none]"
    else
      return "#{honorific} #{name}"
    end
  end

  def self.unique_persons
    order(:pseudonym).uniq(:pseudonym).pluck(:pseudonym)
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      Person.create! row.to_hash
    end
  end
end
