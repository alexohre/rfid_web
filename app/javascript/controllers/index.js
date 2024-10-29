// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FacultyDepartmentController from "./faculty_department_controller"
application.register("faculty-department", FacultyDepartmentController)

import FetchTitleController from "./fetch_title_controller"
application.register("fetch-title", FetchTitleController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import LinkCopyController from "./link_copy_controller"
application.register("link-copy", LinkCopyController)

import LinkCopyMobileController from "./link_copy_mobile_controller"
application.register("link-copy-mobile", LinkCopyMobileController)

import PreviewsController from "./previews_controller"
application.register("previews", PreviewsController)

import SemesterController from "./semester_controller"
application.register("semester", SemesterController)
