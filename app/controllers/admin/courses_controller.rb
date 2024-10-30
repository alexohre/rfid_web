class Admin::CoursesController < AdminController
  def destroy
    lecturer = Lecturer.find(params[:lecturer_id])
    course = lecturer.courses.find(params[:id])

    if lecturer.courses.delete(course)
      redirect_to admin_lecturer_path(lecturer), notice: "Course removed from lecturer."
    else
      redirect_to admin_lecturer_path(lecturer), alert: "Unable to remove course."
    end
  end
end
