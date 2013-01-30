# -*- coding: utf-8 -*-

require_relative 'season_spec'
require_relative 'field_set'
require 'nokogiri'

module CFRP
  class FMMigrator
    attr_reader :doc
    attr_reader :season_spec

    def initialize(xml, season)
      @doc = Nokogiri::XML.parse(xml)
      @season_spec = SeasonSpec.retrieve_for season
    end

    def fieldsets
      @doc.css("FMPXMLRESULT RESULTSET ROW").reduce([]) do |fieldsets, r|
        k = r.css("COL")
        fieldsets << CFRP::FieldSet.new(k, @season_spec)
      end
    end

    def registers
      fieldsets.reduce([]) do |registers, fs|
        register_data = extract_register_data(fs)

        register_data[:register_plays_attributes] =
          extract_play_data(fs)

        register_data[:ticket_sales_attributes] =
          extract_ticket_sales_data(fs)

        register = Register.new(register_data)

        Array(extract_register_image_data(fs)).each do |ri_data|
          clean_register_image_data(ri_data[:filepath])
          register.register_images.build(ri_data)
        end

        register.save

        registers << register
      end
    end

    private

    def extract_register_data(entry)
      {
        :weekday => entry.weekday,
        :date => entry.date,
        :season => entry.season,
        :register_num => entry.register_num,
        :payment_notes => entry.payment_notes,
        :page_text => entry.page_text,
        :total_receipts_recorded_l => entry.total_receipts_recorded_l.to_i,
        :total_receipts_recorded_s => entry.total_receipts_recorded_s.to_i,
        :representation => entry.representation,
        :for_editor_notes => entry.for_editor_notes,
        :misc_notes => entry.misc_notes,
        :register_period_id => entry.register_period_id,
        :signatory => entry.signatory,
        :verification_state_id => 2
      }
    end

    def extract_play_data(entry)
      [entry.play1, entry.play2].reduce([]) do |register_plays, play|
        p = play.split(' | ')

        ordering = register_plays.count + 1

        firstrun = (entry.send("play#{ordering}_firstrun") == 'yes')
        newactor = entry.newactor ? entry.newactor : ''
        actorrole = entry.actorrole ? entry.actorrole : ''

        register_plays << {
          :ordering => ordering,
          :firstrun => firstrun,
          :newactor => newactor,
          :actorrole => actorrole,
          :play_attributes => {
            :title => p[0],
            :genre => p[1],
            :author => p[2]
          }
        }
      end
    end

    def extract_ticket_sales_data(entry)
      entry.ticket_sales.reduce([]) do |ticket_sales, ts|
        ticket_sales <<
          # Kinda weird format to match how we deal with the attributes
          # in the model class...result of parsed JSON.
          [ ticket_sales.count,
            {
              :id => nil,
              :seating_category_id => ts.seating_category_id,
              :total_sold => ts.total_sold,
              :price_per_ticket_l => ts.price_per_ticket_l,
              :price_per_ticket_s => ts.price_per_ticket_s,
              :recorded_total_l => ts.recorded_total_l,
              :recorded_total_s => ts.recorded_total_s
            }
          ]
      end
    end

    def extract_register_image_data(entry)
      [entry.image_front, entry.image_back].reduce([]) do |ri_data, path|
        unless path.nil? || path.empty?
          matches = path.match(%r|((M119_02_R\d*)_\d*\w*\.jpg)$|)
          formatted_path = "images/jpeg-150-80/#{matches[2]}/#{matches[1]}"
          ri_data << { :filepath => formatted_path }
        end
      end
    end

    def clean_register_image_data(filepath)
      ri = RegisterImage.find_by_filepath(filepath)
      unless ri.nil?
        r = Register.find_by_id(ri.register_id)
        r.destroy unless r.nil?
        ri.destroy
      end
    end
  end
end
