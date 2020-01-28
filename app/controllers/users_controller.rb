class UsersController < ApplicationController
  before_action :set_user, only: %i[
    show
    edit
    update
    destroy
  ]

  before_action :logged_in?, only: %i[
    index
    show
    edit
    update
    destory
  ]

  before_action :correct_user?, only: %i[
    show
    edit
    update
  ]
  before_action :sas_admin?, only: %i[
    destroy
  ]

  def index
    if current_user.sas_admin?
      @users = User.all
    else
      not_found
    end
  end

  def show
    @qualifications = current_user.qualifications
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'Successfully registered.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if params[:user]
      params.require(:user).permit(
          :email,
          :password,
          :password_confirmation,
          :role,
          :university_id,
          :title,
          :first_name,
          :last_name,
          :address,
          :gender,
          :nationality,
          :birthdate,
          :phone,
          :nric_passport
      )
    else
      params.permit(
          :email,
          :password,
          :password_confirmation,
          :role,
          :university_id,
          :title,
          :first_name,
          :last_name,
          :address,
          :gender,
          :nationality,
          :birthdate,
          :phone,
          :nric_passport
      )
    end
  end

  def correct_user?
    not_found unless current_user.sas_admin? || current_user == User.find(params[:id])
  end
end
