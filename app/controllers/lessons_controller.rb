class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_enrollment_for_lesson_access

  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def current_course
    @current_course ||= current_lesson.section.course
  end

  def require_enrollment_for_lesson_access
    if current_course.user != current_user && !current_user.enrolled_in?(current_course)
      redirect_to course_path(current_course), alert: 'You must be enrolled to view this lesson.'
    end
  end
end
