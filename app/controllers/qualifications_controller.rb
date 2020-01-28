class QualificationsController < ApplicationController
  before_action :set_qualification, only: [:show, :edit, :update, :destroy]

  before_action :logged_in?, only: %i[
    new
    create
    edit
    update
    destroy
    index
  ]

  def index
    @qualifications = current_user.qualifications.order(grade: :asc).all
  end

  def show
  end

  def new
    @qualification = Qualification.new
  end

  def edit
  end

  def create
    @qualification = Qualification.new(qualification_params)
    respond_to do |format|
      if @qualification.save
        format.html { redirect_to qualifications_path, notice: 'Qualification was successfully created.' }
        format.json { render :show, status: :created, location: @qualification }
      else
        format.html { render :new }
        format.json { render json: @qualification.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @qualification.update(qualification_params)
        format.html { redirect_to qualifications_path, notice: 'Qualification was successfully updated.' }
        format.json { render :show, status: :ok, location: @qualification }
      else
        format.html { render :edit }
        format.json { render json: @qualification.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @qualification.destroy
    respond_to do |format|
      format.html { redirect_to qualifications_url, notice: 'Qualification was successfully removed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_qualification
    @qualification = Qualification.find(params[:id])
  end

  def qualification_params
    if params[:qualification]
      params.require(:qualification).permit(:user_id, :paper_id, :grade)
    else
      params.permit(:user_id, :paper_id, :grade)
    end
  end
end
