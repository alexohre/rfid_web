# app/controllers/account/exams_controller.rb
class Account::ExamsController < AccountController
  before_action :set_semesters, only: [:register_exam]

  def register_exam
    @semester = Semester.find_by(id: params[:semester_id]) if params[:semester_id]
    @courses = if params[:course_code].present?
                 Course.where("course_code ILIKE ?", "%#{params[:course_code]}%")
               else
                 []
               end

    # Handle course registration on form submission
    if request.post?
      # Ensure semester and course IDs are present
      unless params[:semester_id].present? && params[:course_ids].present?
        return render json: { success: false, message: "Please select a semester and at least one course." }, status: :unprocessable_entity
      end

      semester = Semester.find(params[:semester_id])
      course_ids = params[:course_ids].map(&:to_i)  # Convert course IDs to integers

      # Register selected courses for the current account within the chosen semester
      course_ids.each do |course_id|
        course = Course.find(course_id)
        
        # Create an enrollment if one does not already exist for this course in the semester
        Enrollment.find_or_create_by(account: current_account, course: course, semester: semester)
      end

      render json: {
          success: true,
          message: "Successfully registered for selected courses.",
          redirect_url: my_exams_account_exams_path
        }
    end
  end

  def my_exams
    # Get the account's enrolled courses
    enrollments = current_account.enrollments.includes(:course, :semester)
    @registered_courses = enrollments.group_by { |enrollment| enrollment.semester }
  end

  private

  def set_semesters
    @semesters = Semester.all
  end
end