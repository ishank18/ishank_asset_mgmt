class TagsController < ApplicationController
  def index
  end

  def show
  	@tag = Tag.where(:id => params[:id].to_i).first
  end

  def edit
  end

  def new
  end

end
