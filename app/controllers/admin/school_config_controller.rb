class Admin::SchoolConfigController < AdminController

  def index
    @title = "School Configuration"
    
    @faculties = Faculty.all
    @departments = Department.all
    @courses = Course.all

    @faculty = Faculty.new
    @department = Department.new
    @course = Course.new
  end

  def create_faculty
     @faculty = Faculty.new(faculty_params)
    if @faculty.save
      redirect_to admin_school_config_path, notice: 'Faculty created successfully.'
    else
      redirect_to admin_school_config_path, alert: 'Error creating faculty.'
    end
  end

  def update_faculty
    @faculty = Faculty.find(params[:id])
    if @faculty.update(faculty_params)
      redirect_to admin_school_config_path, notice: 'Faculty name updated successfully.'
    else
      redirect_to admin_school_config_path, alert: 'Error updating faculty name.'
    end
  end

  def create_department
    @department = Department.new(department_params)
    if @department.save
      redirect_to admin_school_config_path, notice: 'Department created successfully.'
    else
      redirect_to admin_school_config_path, alert: 'Error creating department.'
    end
  end

  def update_department
    @department = Department.find(params[:id])
    if @department.update(department_params)
      redirect_to admin_school_config_path, notice: 'Department name updated successfully.'
    else
      redirect_to admin_school_config_path, alert: 'Error updating faculty name.'
    end
  end

  def create_courses
    @course = Course.new(course_params)
    if @course.save
      redirect_to admin_school_config_path, notice: 'Course created successfully.'
    else
      redirect_to admin_school_config_path, alert: 'Error creating course.'
    end
  end

  def update_courses
    @course = Course.find(params[:id])
    if @course.update(course_params)
      redirect_to admin_school_config_path, notice: 'Course name updated successfully.'
    else
      redirect_to admin_school_config_path, alert: 'Error updating faculty name.'
    end
  end

  private

  def faculty_params
    params.require(:faculty).permit(:name)
  end

  def department_params
    params.require(:department).permit(:name, :faculty_id)
  end

  def course_params
    params.require(:course).permit(:course_title, :course_code, :department_id)
  end

end