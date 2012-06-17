class UsersController < ApplicationController

  # FILTER
  # by default, before filters apply to every action in a controller
  # so here we restrict the filter to act only on the :edit and :update
  # actions by passing the appropriate :only options hash
  before_filter :signed_in_user,  only: [:index, :edit, :update]
  before_filter :correct_user,    only: [:edit, :update]
  before_filter :admin_user,      only: :destroy

  # PUBLIC METHODS
  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @ride = Ride.first
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      # Handle a successful save
      sign_in @user
      flash[:success] = "Welcome to Noompang!"
      redirect_to @user
    else
      # Unsuccessful save
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_path
  end

  # PRIVATE METHODS
  private

    def signed_in_user
      redirect_to signin_path, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
