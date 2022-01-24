class ExperiencesController < ApplicationController
  before_action :logged_in_user, only: [:new]
  
  def new
    current_user.profile.experiences.create
    flash[:success] = "Eexperience added."
    redirect_to edit_url
  end

end
