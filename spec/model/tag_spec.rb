require 'spec_helper'

describe Tag do 
	before(:each) do
		@valid_attributes = {
			:name => "Apple"
		}
		@tag = Tag.new @valid_attributes
	end
	
	it "should have and belong to many tags" do
		@tag.should have_and_belong_to_many :assets
	end
	
end	
