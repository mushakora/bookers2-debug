class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:top, :about]
  before_action :baria_user, only: [:edit, :update, :follows, :followers]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end

      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def index
    @user = User.new
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
    @followers = current_user.followers
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @book_ranking = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
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
  	params.require(:user).permit(:name, :introduction, :profile_image, :postcode, :prefecture_name, :address_city, :address_street, :address_building)
  end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  	  @user = User.find(params[:id])
      unless @user == current_user
  		redirect_to user_path(current_user)
  	  end
  end
end
