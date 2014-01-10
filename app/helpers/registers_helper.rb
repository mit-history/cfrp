module RegistersHelper
	def irregular_receipt?(seating_category)
		seating_category.name =~ /\AIrregular Receipt/
	end

	def irregular_receipt_field_name(seating_category)
		name = seating_category.name
		if name =~ /(\d+)/
			"irregular_receipts_name_#{$1}".to_sym
		else
			"#{seating_category.name.gsub(" ", '').underscore}_name".to_sym
		end
	end
end
