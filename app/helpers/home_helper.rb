module HomeHelper

	def tag_class tag
		tag_count = tag.assets.size
		if(tag_count == 1)
			"TagSizeOne TagSpan"
		elsif(tag_count == 2)
			"TagSizeTwo TagSpan"
		elsif(tag_count == 3)
			"TagSizeThree TagSpan"
		elsif(tag_count == 4)
			"TagSizeFour TagSpan"
		else			
			"TagSizeBig TagSpan"
		end	
	end
	
end
