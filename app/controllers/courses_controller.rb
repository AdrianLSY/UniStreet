class CoursesController < ApplicationController
  before_action :set_course, only: %i[
    show
    edit
    update
    destroy
  ]

  before_action :logged_in?, only: %i[
    new
    create
    edit
    update
    destroy
  ]

  before_action :sas_admin?, only: %i[
    new
    create
    edit
    update
    destroy
  ]

  def index
    if !current_user || !current_user.student?
      @courses = Course.all
    else
      @courses = []
      grades = current_user.summary
      courses = Course.where(status: 'ongoing')
      for course in courses
        if (
        (course.credit_amount_req <= grades[:SPM]) || (course.credit_amount_req <= grades[:IGCSE])
        ) && (
        (course.science_amount_req <= grades[:sciences][:igcse_credit]) || (course.science_amount_req <= grades[:sciences][:spm_credit])
        ) && (
        (course.maths_credit? == grades[:math][:igcse_credit]) || (course.maths_credit? == grades[:math][:spm_credit])
        ) && (
        (course.maths_pass? == grades[:math][:igcse_pass]) || (course.maths_pass? == grades[:math][:spm_pass])
        ) && (
        (course.english_credit? == grades[:english][:igcse_credit]) || (course.english_credit? == grades[:english][:spm_credit])
        ) && (
        (course.english_pass? == grades[:english][:igcse_pass]) || (course.english_pass? == grades[:english][:spm_pass])
        )
          @courses.append(course)
        end
      end
      unless current_user.applications.empty?
        for application in current_user.applications
          if @courses.include? application.course
            @courses.delete(application.course)
          end
        end
      end
    end
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    respond_to do |format|
      if @course.save
        format.html { redirect_to courses_path, notice: 'Course was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to courses_path, notice: 'Course was successfully updated.' }
        format.json { render :index, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course.applications.destroy_all
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete
    Course.find(params[:id]).completed!
    redirect_to courses_path
  end

  def ongoing
    Course.find(params[:id]).ongoing!
    redirect_to courses_path
  end

  private

    def set_course
      @course = Course.find(params[:id])
    end

  def course_params
    if params[:course]
      params.require(:course).permit(
          :name,
          :description,
          :intake,
          :status,
          :university_id,
          :credit_amount_req,
          :english_grade_req,
          :math_grade_req,
          :science_amount_req
      )
    else
      params.permit(
          :name,
          :description,
          :intake,
          :status,
          :university_id,
          :credit_amount_req,
          :english_grade_req,
          :math_grade_req,
          :science_amount_req
      )
    end
  end
end
