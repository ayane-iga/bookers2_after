
class UsersController < ApplicationController

before_action :authenticate_user!

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@hon = Book.new
  end

  def edit
  	@user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
  	  redirect_to user_path(@user.id)
    else render action: :edit
    end
  end

  def index
  	@users = User.all
    @user = current_user
    @hon = Book.new
  end

  private
  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

end