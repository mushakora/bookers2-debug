class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :baria_user, only: [:edit, :update, :follows, :followers, :show, :search]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def index
    @user = User.new
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @followers = current_user.followers
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end

  def follows
      @followers = current_user.followings
      render "follows"
  end

  def followers
      @followers = current_user.followers
      render "followers"
  end


  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  	  @user = User.find(params[:id])
      unless @user == current_user
  		redirect_to user_path(current_user)
  	  end
  end
end
