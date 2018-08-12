# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy,:assign_member]
  before_action :authorize_as_admin, only: [:create,:update,:destroy, :assign_member]

  # GET /lists
  def index
    # get current user lists
    @lists = (current_user.lists + List.where("created_by" => current_user.id)).uniq
    #@lists = Membership.all
    json_response(@lists)
  end

  # POST /lists
  def create
    # create list belonging to current user
    if list_params['created_by'].to_i == current_user.id
      @list = List.create!(list_params)
      #@list = List.create!(list_params)
      json_response(@list, :created)
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_created_by)
    end
  end

  # GET /lists/:id
  def show
    render json: @list, include: :cards
    #json_response(@list,:cards)
  end

  # PUT /lists/:id
  def update
    if @list.created_by.to_i == current_user.id
      @list.update(list_params_new)
      head :no_content
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_created_by)
    end
  end

  # DELETE /lists/:id
  def destroy
    if @list.created_by.to_i == current_user.id
      @list.destroy
      head :no_content
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_created_by)
    end
  end

  # POST /lists/assign_member/:id
  def assign_member
    if @list.created_by.to_i == current_user.id
      #if users_params[:users]
      users_params['user_ids'].each.to_i do |id|
        @list.users << User.find(id)
      end
      #end
        json_response(@list,:created)#, :created)
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_created_by)
    end
  end

  private

  def list_params
    # whitelist params
    params.permit(:title,:created_by)#, :created_by)
  end

  def list_params_new
    # whitelist params
    params.permit(:title)#, :created_by)
  end

  def users_params
    # whitelist params
    params.permit(:list,:id,:user_ids, [])
  end

  def set_list
    @list = List.find(params[:id])
  end
end
