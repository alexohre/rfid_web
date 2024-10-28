import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["department"];

	connect() {
		console.log("FacultyDepartmentController connected");
	}

	updateDepartments(event) {
		const facultyId = event.target.value;
		if (facultyId) {
			fetch(`/admin/faculties/${facultyId}/departments`)
				.then((response) => response.json())
				.then((departments) => {
					this.departmentTarget.innerHTML =
						'<option value="">Select Department</option>';
					departments.forEach((department) => {
						this.departmentTarget.innerHTML += `<option value="${department.id}">${department.name}</option>`;
					});
				});
		} else {
			this.departmentTarget.innerHTML =
				'<option value="">Select Department</option>';
		}
	}
}
