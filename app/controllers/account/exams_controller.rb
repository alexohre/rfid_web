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
      selected_course_ids = params[:course_ids] || []
      selected_courses = Course.where(id: selected_course_ids, semester: @semester)

      selected_courses.each do |course|
        ExamRegistration.find_or_create_by(account: current_account, course: course, exam: course.exam)
      end

      flash[:notice] = "Successfully registered for selected courses."
      redirect_to my_exams_account_exams_path
    end
  end


  private

  def set_semesters
    @semesters = Semester.all
  end
end
