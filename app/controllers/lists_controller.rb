# app/controllers/lists_controller.rb
class ListsController < ApplicationController
  before_action :set_list, only: [:show, :update, :destroy,:assign_member,:unassign_member]
  before_action :authorize_as_admin, only: [:create,:update,:destroy, :assign_member, :unassign_member]

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

  # POST /lists/:id/assign_member
  def assign_member
    if @list.created_by.to_i == current_user.id
      if params[:users_ids]
        @list.user_ids << params[:users_ids]
        users_array = params[:users_ids].split(',')
        users_array.each do |a|
          @list.users << User.find(a)
        end
        head :created
      else
        raise(ExceptionHandler::AuthenticationError, Message.invalid_params_users_ids)
      end
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_created_by(params[:id]))
    end
  end

  # POST /lists/:id/unassign_member
  def unassign_member
    if @list.created_by.to_i == current_user.id
      if params[:users_ids]
        @list.user_ids << params[:users_ids]
        users_array = params[:users_ids].split(',')
        users_array.each do |a|
          @list.users.destroy(User.find(a))
        end
        head :no_content
      else
        raise(ExceptionHandler::AuthenticationError, Message.invalid_params_users_ids)
      end
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_created_by(params[:id]))
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

  #def users_params
    # whitelist params
    #params.permit(:list,:id, user_ids: [])
    #params.permit(:users_ids)
  #end

  def set_list
    @list = List.find(params[:id])
  end
end
