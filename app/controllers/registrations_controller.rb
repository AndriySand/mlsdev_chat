class RegistrationsController < Devise::RegistrationsController

  def create_user
    build_resource(user_params)
    if resource.save
      user_attr = {id: resource.id, name: resource.name, email: resource.email}
      render json: { user: user_attr.merge({messages_count: resource.messages.count}) }, status: :created
    else
      render_json_error(resource.errors.messages, :unprocessable_entity)
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

end
