module HomeHelper

	def tag_class tag
		tag_count = tag.assets.size
		(tag_count < 5) ? "tag TagSize#{tag_count}" : "tag TagSizeBig"
	end
	
	def generate_search_info params
	  output_string = "Showing reults for "
	  output_string = "#{output_string} assets with <i>#{params[:by].try(:humanize)}</i> like <b>#{params[:asset]}</b>;" if params[:asset].present?
	  output_string = "#{output_string} status <b>#{params[:asset_status]}</b>;" if params[:asset_status].present?
	  output_string = "#{output_string} type <b>#{params[:asset_type]}</b>;" if params[:asset_type].present?
	  output_string = "#{output_string} after purchase date <b>#{params[:start]}</b>;" if params[:start].present?
	  output_string = "#{output_string} before purchase date <b>#{params[:end]}</b>;" if params[:end].present?
	  if (params[:asset].present? || params[:asset_status].present? || params[:asset_type].present? || params[:start].present? || params[:end].present?)
	    output_string = "#{output_string} assigned to employee with name like <b>#{params[:employee]}</b>;" if params[:employee].present?
    else
      output_string = "#{output_string} employee with name like <b>#{params[:employee]}</b>;" if params[:employee].present?
    end
	  
	  if output_string == "Showing reults for "
	    "Please select a field to search."
    else
      output_string
    end
  end
	
end
