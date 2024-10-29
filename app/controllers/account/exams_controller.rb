# app/controllers/account/exams_controller.rb
class Account::ExamsController < AccountController
  before_action :set_semesters, only: [:register_exam]

  def register_exam
    @selected_courses = current_account.exam_registrations.includes(:course).map(&:course)
    @semester = Semester.find_by(id: params[:semester_id]) if params[:semester_id]
    @courses = if params[:course_code].present?
                 Course.where("course_code ILIKE ?", "%#{params[:course_code]}%")
               else
                 @semester ? @semester.courses : []
               end

    # Post action to register for selected courses
    if request.post?
      unless params[:semester_id].present?
        return render json: { success: false, message: "Please select a semester." }, status: :unprocessable_entity
      end

      begin
        @semester = Semester.find(params[:semester_id])
        selected_course_ids = params[:course_ids] || []
        selected_courses = Course.where(id: selected_course_ids, semester: @semester)

        selected_courses.each do |course|
          ExamRegistration.find_or_create_by!(account: current_account, course: course, exam: course.exam)
        end

        render json: {
          success: true,
          message: "Successfully registered for selected courses.",
          redirect_url: my_exams_account_exams_path
        }
      rescue ActiveRecord::RecordNotFound
        logger.error("Semester not found with id: #{params[:semester_id]}")
        render json: { success: false, message: "Invalid semester selected." }, status: :not_found
      rescue => e
        logger.error("Registration error: #{e.message}")
        render json: { success: false, message: "An error occurred while registering courses: #{e.message}" }, status: :unprocessable_entity
      end
    end
  end

  private

  def set_semesters
    @semesters = Semester.all
  end
end