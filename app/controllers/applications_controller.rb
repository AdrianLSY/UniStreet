class ApplicationsController < ApplicationController
  before_action :set_application, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?
  # GET /applications
  # GET /applications.json
  def index
    if current_user.student?
      @applications = current_user.applications.all
    elsif current_user.university_admin?
      @applications = current_user.university.applications.all
    else
      @applications = Application.all
    end
  end

  # GET /applications/1
  # GET /applications/1.json
  def show
  end

  # GET /applications/new
  def new
    @application = Application.new(user_id: current_user.id, course_id: params[:course_id])

    respond_to do |format|
      if @application.save
        format.html { redirect_to courses_path, notice: 'Application was successfully submitted.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /applications/1/edit
  def edit
  end

  # POST /applications
  # POST /applications.json
  def create
    @application = Application.new(application_params)

    respond_to do |format|
      if @application.save
        format.html { redirect_to courses_path, notice: 'Application was successfully submitted.' }
        format.json { render :show, status: :created, location: @application }
      else
        format.html { render :new }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /applications/1
  # PATCH/PUT /applications/1.json
  def update
    respond_to do |format|
      if @application.update(application_params)
        format.html { redirect_to courses_path, notice: 'Application was successfully updated.' }
        format.json { render :show, status: :ok, location: @application }
      else
        format.html { render :edit }
        format.json { render json: @application.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /applications/1
  # DELETE /applications/1.json
  def destroy
    @application.destroy
    respond_to do |format|
      format.html { redirect_to applications_url, notice: 'Application was successfully removed.' }
      format.json { head :no_content }
    end
  end

  def approve
    Application.find(params[:id]).approved!
    redirect_to applications_path
  end

  def deny
    Application.find(params[:id]).denied!
    redirect_to applications_path
  end

  def pending
    Application.find(params[:id]).pending!
    redirect_to applications_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_application
      @application = Application.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def application_params
      if params[:application]
        params.require(:application).permit(:user_id, :course_id, :status)
      else
        params.permit(:user_id, :course_id, :status)
      end
    end
end
