class Lecturer::SettingController < LecturerController
  before_action :check_profile_completion, only: [:profile]

  def change_password
    @title = "Change Your Password"
    @resource = current_lecturer
    @resource_name = :lecturer
    @error_messages = flash[:alert] if flash[:alert].present?
  end

  def profile
    @resource_name = :lecturer
    name = current_lecturer.first_name.present? ? current_lecturer.first_name : current_lecturer.username
    @title = "#{name}'s Profile"
  end

  private

  def check_profile_completion
    if current_lecturer && (current_lecturer.first_name.blank? || current_lecturer.last_name.blank? )
      redirect_to edit_lecturer_registration_path, alert: "Please complete your profile information."
    end
  end

end