class SearchsController < ApplicationController
  def search
  	  @user = User.find(params[:id])
      if params[:user].present?
         @users = User.where('name LIKE ?', "%#{params[:name]}%")
      else
         @users = User.none
      end
  end
end
