class UsersController < ApplicationController
  def index
    @book = Book.new
    @user = current_user
    @users = User.all

  end
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def create
    @user = User.new(users_params)
    @user.user_id = current_user.id
    if @user.save
      redirect_to book_path(@user.id)
      flash[:notice] = "You have create book successfully"
    else
      @books = Book.all
      render :index
    end
    redirect_to user_path(user.id)
  end

  def destroy
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    else
       redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:notice] = "You have update book successfully"
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
end
