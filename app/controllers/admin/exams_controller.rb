# app/controllers/account/exams_controller.rb
class Admin::ExamsController < AdminController
  before_action :set_semesters, only: [:register_exam]

  def index 
    @exam = Exam.new
    @semesters = Semester.all
    @courses = Course.all

    @exams = Exam.includes(:course).order(id: :desc)
  end

  def create
    # Get the account's enrolled courses
    @exam = Exam.new(exam_params)
    if @exam.save
      redirect_to admin_exams_path, notice: "Exam created successfully!"
    else
      redirect_to admin_exams_path, alert: "Oops, something went wrong!"
    end
  end

  private

  def set_semesters
    @semesters = Semester.all
  end

  def exam_params
    params.require(:exam).permit(:semester_id, :course_id, :date, :start_time, :end_time)
  end
end