// app/javascript/controllers/exam_registration_controller.js
// Connects to data-controller="exam-registration"
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
	static targets = ["coursesList", "selectedCourses", "semester"];

	static values = {
		semester: Number,
		courses: Array,
	};

	connect() {
		this.selectedCourses = new Set();
		this.coursesValue = this.coursesValue || [];
		this.updateAddButtonStates();
	}

	semesterChanged(event) {
		this.semesterValue = event.target.value; // Stores the selected semester ID
		console.log("value:", this.semesterValue);
	}

	add(event) {
		const courseElement = event.target.closest(".d-flex");
		const courseId = courseElement.dataset.courseId;
		const courseCode = courseElement.querySelector("h6").textContent;
		const courseTitle = courseElement.querySelector("small").textContent;

		if (!this.selectedCourses.has(courseId)) {
			this.selectedCourses.add(courseId);
			this.addToSelectedList({
				id: courseId,
				code: courseCode,
				title: courseTitle,
			});

			const addButton = courseElement.querySelector("button");
			this.disableAddButton(addButton);
		}
	}

	remove(event) {
		const courseElement = event.target.closest(".d-flex");
		const courseId = courseElement.dataset.courseId;

		this.selectedCourses.delete(courseId);
		courseElement.remove();

		const originalCourseElement = this.coursesListTarget.querySelector(
			`[data-course-id="${courseId}"]`
		);
		if (originalCourseElement) {
			const addButton = originalCourseElement.querySelector("button");
			this.enableAddButton(addButton);
		}
	}

	addToSelectedList(course) {
		const html = `
      <div class="d-flex justify-content-between align-items-center border-bottom py-3" data-course-id="${course.id}">
        <div>
          <h6 class="mb-0 fw-bold">${course.code}</h6>
          <small class="text-dark d-block mb-1">${course.title}</small>
        </div>
        <button class="btn btn-sm btn-danger" type="button" data-action="exam-registration#remove">Remove</button>
      </div>
    `;
		this.selectedCoursesTarget.insertAdjacentHTML("beforeend", html);
	}

	submitRegistration(event) {
		event.preventDefault();

		console.log("Form value:", this.semesterValue); // Verify semesterValue before proceeding

		if (!this.semesterValue) {
			alert("Please select a semester.");
			return;
		}

		if (this.selectedCourses.size === 0) {
			alert("Please select at least one course.");
			return;
		}

		const form = new FormData();
		form.append("semester_id", this.semesterValue); // Add the stored semester ID
		this.selectedCourses.forEach((courseId) => {
			form.append("course_ids[]", courseId);
		});

		// Show loading state
		const submitButton = event.currentTarget;
		const originalText = submitButton.textContent;
		submitButton.disabled = true;
		submitButton.textContent = "Registering...";

		fetch("/account/exams/register_exam", {
			method: "POST",
			body: form,
			headers: {
				"X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
					.content,
				Accept: "application/json",
			},
		})
			.then((response) => {
				if (!response.ok) {
					throw new Error(`HTTP error! status: ${response.status}`);
				}
				return response.json();
			})
			.then((data) => {
				if (data.success) {
					// Show success message if you have a flash message system
					window.location.href = data.redirect_url;
				} else {
					alert(data.message || "An error occurred while registering courses.");
				}
			})
			.catch((error) => {
				console.error("Error:", error);
				alert("An error occurred while registering courses. Please try again.");
			})
			.finally(() => {
				// Reset button state
				submitButton.disabled = false;
				submitButton.textContent = originalText;
			});
	}

	disableAddButton(button) {
		button.disabled = true;
		button.classList.remove("btn-primary");
		button.classList.add("btn-secondary");
		button.textContent = "Added";
	}

	enableAddButton(button) {
		button.disabled = false;
		button.classList.remove("btn-secondary");
		button.classList.add("btn-primary");
		button.textContent = "Add";
	}

	updateAddButtonStates() {
		const addButtons = this.coursesListTarget.querySelectorAll(
			'button[data-action="exam-registration#add"]'
		);
		addButtons.forEach((button) => {
			const courseElement = button.closest(".d-flex");
			const courseId = courseElement.dataset.courseId;
			if (this.selectedCourses.has(courseId)) {
				this.disableAddButton(button);
			} else {
				this.enableAddButton(button);
			}
		});
	}
}
