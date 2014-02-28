namespace :page_de_gauche do
  desc "Migrates page de gauche values from old schema to new"
  task :migrate => :environment do
    Register.all.each do|register|
      begin
        current_pdg = register.page_de_gauche

        next if current_pdg.blank?

        pdg = PageDeGauche.where(category: current_pdg).first_or_create!

        LhpCategoryAssignment.create!(register: register, page_de_gauche: pdg)

      rescue StandardError => e
        puts "Failed! Reason: #{e.inspect}"
      end
    end
  end
end
