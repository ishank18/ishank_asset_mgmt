class TagsController < ApplicationController
  def index
  end

  def show
    ### Use where instead of find
  	@tag = Tag.find(params[:id])
  end

  def edit
  end

  def new
  end

end
