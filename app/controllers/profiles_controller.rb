class ProfilesController < ApplicationController
    include HomeHelper
    include ProfilesHelper

    before_action :logged_in_user, only: [:update]
    before_action :correct_user,   only: [:update]

    def update
      updated_profile_params = update_array_attributes_in_params(profile_params)
      @profile = Profile.find(params[:id])
      if @profile.update(updated_profile_params)
        flash[:success] = "Profile updated successfully."
        redirect_to edit_url
      else
        flash[:danger] = "Profile update failed."
        redirect_to root_url
      end
    end

    def correct_user
      @profile = Profile.find(params[:id])
      @user = User.find(@profile.user_id)
      redirect_to(root_url) unless @user == current_user
    end

    def share
        @profile = Profile.find_by(user_id: params[:id]);
        if @profile
            render('users/profile')
        else
            flash[:error] = "Profile not found."
            redirect_to login_url
        end
    end

    private
        def profile_params
        params.require(:profile).permit(:name, :avatar, :job_title, :total_experience, :overview, 
            :career_highlights, :primary_skills, :secondary_skills,
            :educations_attributes => [ :id, :school, :degree, :description, :start, :end, :_destroy],
            :experiences_attributes => [ :id, :company, :position, :description, :start, :end, :_destroy, {:projects_attributes => [
                :title, :project_url, :stack, :description, :id, :_destroy
            ]}]
        )
    end
end
