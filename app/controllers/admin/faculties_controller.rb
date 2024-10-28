class Admin::FacultiesController < AdminController

  def departments
    @faculty = Faculty.find(params[:id])
    render json: @faculty.departments.select(:id, :name) # Only send necessary fields
  end

end