class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @users = User.all
    @books = @user.books.reverse_order
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
    @books =Book.all
  end

  def edit
    @user = User.find(params[:id])
    @users = User.all
    if current_user.id != @user.id
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end

  def following
    @user = User.find_by(id: params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find_by(id: params[:id])
    @users = @user.followers
    render 'show_follower'
  end


  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
