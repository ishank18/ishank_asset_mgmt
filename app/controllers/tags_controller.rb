class TagsController < ApplicationController
  def index
  end

  def show
  	@tag = Tag.find(params[:id])
  end

  def edit
  end

  def new
  end

end
