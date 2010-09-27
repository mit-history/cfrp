# -*- coding: utf-8 -*-
class PageTextTemplateDefaults < ActiveRecord::Migration
  def self.up
    pageTextTemplateDefault = PageTextTemplate.new(:template_text => 'Arrêté par nous Semainiers la Recette de ce jour __ mil sept cent soixante - __ montant à la somme de __')
    pageTextTemplateDefault.id = 2
    pageTextTemplateDefault.save
  end

  def self.down
    PageTextTemplate.find(2).destroy
  end
end
