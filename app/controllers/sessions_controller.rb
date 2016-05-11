class SessionsController < Devise::SessionsController
  skip_before_filter :verify_signed_out_user
  prepend_before_filter :require_no_authentication, :only => [:create ]

  def create
    user = User.find_by_name(params[:user][:name])
    render_json_error('Invalid name', :unauthorized) and return if user.nil?
    if user.valid_password?(params[:user][:password])
      sign_in('user', user)
      render json: { user: {id: user.id, name: user.name} }, status: :created
    else
      render_json_error('Invalid password', :unauthorized)
    end
  end

  def destroy
    if sign_out(current_user)
      render json: { session: "You've successfully logged out" }, status: :moved_permanently
    else
      render_json_error('Invalid session', :unauthorized)
    end
  end

end
