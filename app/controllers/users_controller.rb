class UsersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all
    render_json_error('There are no users', :not_found) unless @users.any?
  end

  def show
    @user = User.find_by_id(params[:id])
    render_json_error('There is no user under this ID', :not_found) unless @user
  end

end
