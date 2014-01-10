module RegistersHelper

	def irregular_receipt_field_name(seating_category)
		"#{seating_category.name.gsub(" ", '').underscore}_name".to_sym
	end

	private

	def create_form_name
	end
end
