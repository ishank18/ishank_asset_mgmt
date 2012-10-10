module HomeHelper

	def tag_class tag
		tag_count = tag.assets.size
		(tag_count < 5) ? "tag TagSize#{tag_count}" : "tag TagSizeBig"
	end
	
end
