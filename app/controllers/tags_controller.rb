class TagsController < ApplicationController
  def index
  end

  def show
    ### Use where instead of find
  	@tag = Tag.where("id = ?", params[:id]).first
  end

  def edit
  end

  def new
  end

end
