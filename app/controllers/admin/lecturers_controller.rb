class Admin::LecturersController < AdminController
  def create
    @lecturer = Lecturer.new(lecturer_params)
    if @lecturer.save
      redirect_to admin_lecturers_path, notice: 'Lecturer was successfully created.'
    else
      redirect_to admin_lecturers_path, alert: 'Error creating lecturer.'
    end
  end

  def index
    @title = "Lecturers"
    @q = Lecturer.ransack(params[:q])
    @pagy, @lecturers = pagy(@q.result(distinct: true).includes(avatar_attachment: :blob).order(id: :desc), items: 8)
    # @pagy, @accounts = pagy(Account.includes(avatar_attachment: :blob).order(id: :desc), items: 8)
  end

  def show
    @courses = Course.all
    @lecturer = Lecturer.find(params[:id])
    @title = "#{@lecturer.first_name.presence}'s profile"
  end

  def update_courses
    @lecturer = Lecturer.find(params[:id])
    
    if params[:lecturer][:course_ids].present?
      @lecturer.lecturer_courses.create(course_id: params[:lecturer][:course_ids])
      redirect_to admin_lecturer_path(@lecturer), notice: 'Course assigned successfully.'
    else
      redirect_to admin_lecturer_path(@lecturer), alert: 'Please select a course.'
    end
  end

  private

  def lecturer_params
    params.require(:lecturer).permit(:first_name, :last_name, :email, :password)
  end
end
