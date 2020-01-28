class UniversitiesController < ApplicationController
  before_action :set_university, only: %i[
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
    @universities = University.all
  end

  def show
  end

  def new
    @university = University.new
  end

  def edit
  end

  def create
    @university = University.new(university_params)

    respond_to do |format|
      if @university.save
        format.html { redirect_to @university, notice: 'University was successfully created.' }
        format.json { render :show, status: :created, location: @university }
      else
        format.html { render :new }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @university.update(university_params)
        format.html { redirect_to @university, notice: 'University was successfully updated.' }
        format.json { render :show, status: :ok, location: @university }
      else
        format.html { render :edit }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @university.applications
      @university.applications.all.destroy_all
    end
    if @university.courses
      @university.courses.destroy_all
    end
    @university.destroy
    respond_to do |format|
      format.html { redirect_to universities_url, notice: 'University was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_university
      @university = University.find(params[:id])
    end

  def university_params
    if params[:university]
      params.require(:university).permit(:name, :description, :user_id, :address, :phone, :email)
    else
      params.permit(:name, :description, :user_id, :address, :phone, :email)
    end
  end
end
