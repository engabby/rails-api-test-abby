#class UsersController < ApplicationController
#end

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # POST /signup
  # return authenticated token upon signup
  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).call
    response = { message: Message.account_created, auth_token: auth_token }
    json_response(response, :created)
  end

  # GET /users
  # return list of all users
  def show
    @users = User.all
    json_response(@users)
  end

  private

  def user_params
    params.permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
