class CreatePageTextTemplates < ActiveRecord::Migration
  def self.up
    create_table :page_text_templates do |t|
      t.text :template_text

      t.timestamps
    end
  end

  def self.down
    drop_table :page_text_templates
  end
end
