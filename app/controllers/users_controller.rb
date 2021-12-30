class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :screen_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new

    @week = []
    @labels = []
    (-6..0).each do |i|
      day_count = @books.term(Date.current+i, Date.current+i+1).count
      @week.push(day_count)
      @labels.push((-i).to_s + '日前')
    end
    @labels[-1] = '今日'
    @labels_j = @labels.to_json.html_safe

    @today_count = @week[-1]
    @yesterday_count = @week[-2]
    @week_count = @week.sum
    @lastweek_count = @books.term(Date.current-13, Date.current-6).count

  end

  def index
    @users = User.all
    @book = Book.new
  end

  def followings
    @user = User.find(params[:id])
  end

  def followers
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  private
    def user_params
       params.require(:user).permit(:name, :introduction, :profile_image)
    end

    def screen_user
      unless params[:id].to_i == current_user.id
        redirect_to user_path(current_user)
      end
    end

end

