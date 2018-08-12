#class ApplicationController < ActionController::API
#  include Response
#  include ExceptionHandler
#end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  # called before every action on controllers
  before_action :authorize_request
  attr_reader :current_user

  private

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end

  # Method for checking if current_user is admin or not.
  def authorize_as_admin
    raise(ExceptionHandler::AuthenticationError, Message.unauthorized) unless !current_user.nil? && current_user.is_admin?
  end
end
