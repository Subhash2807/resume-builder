class ProjectsController < ApplicationController
    include HomeHelper
    include ProfilesHelper

    before_action :logged_in_user, only: [:update]
    before_action :correct_user,   only: [:update]

    def new
      id = params[:format]
      Project.create(experience_id: id)
      flash[:success] = "New Project Added."
      redirect_to edit_url
    end

    def update
    end

end

