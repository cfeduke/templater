class CmsController < ApplicationController
  append_view_path SqlTemplate::Resolver.instance
  
  def respond
    render :template => params[:page]
  end
end