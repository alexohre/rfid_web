import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="semester"
export default class extends Controller {
	static targets = ["courseList"];

	updateCourses(event) {
		const semesterId = event.target.value;
		if (!semesterId) return;

		fetch(`/account/exams/search_courses?semester_id=${semesterId}`, {
			headers: {
				Accept: "text/vnd.turbo-stream.html",
				"Turbo-Frame": "courses_list",
			},
		});
	}

	searchCourses(event) {
		const courseCodeInput = document.querySelector("#courseSearch");
		const semesterSelect = document.querySelector("#semesterSelect");

		if (!courseCodeInput || !semesterSelect) return;

		const courseCode = courseCodeInput.value;
		const semesterId = semesterSelect.value;

		if (!semesterId) return;

		fetch(
			`/account/exams/search_courses?semester_id=${semesterId}&course_code=${courseCode}`,
			{
				headers: {
					Accept: "text/vnd.turbo-stream.html",
					"Turbo-Frame": "courses_list",
				},
			}
		);
	}
}
