class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    if(params.has_key?(:card_id))
      @comments = Comment.where(card_id: params['card_id'])
      json_response(@comments)

    elsif (params.has_key?(:comment_id))
      @comments = Comment.where(parent_id: params['comment_id'])
      json_response(@comments)
    else
      raise(ExceptionHandler::AuthenticationError, Message.missing_parameters)
    end
  end

  # POST /comments
  def create
    if(params.has_key?(:card_id))
      @card = Card.find(params['card_id'])
      @comment = @card.comments.new(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      #@comment.after_save
      json_response(@comment, :created)

    elsif (params.has_key?(:comment_id))
      @parent = Comment.find(params['comment_id'])
      @comment = @parent.replies.new(comment_params)
      @comment.user_id = current_user.id
      @comment.parent_id = @parent.id
      @comment.card_id = @parent.card_id
      @comment.save
      #@comment.after_save
      json_response(@comment, :created)

    else
      raise(ExceptionHandler::AuthenticationError, Message.missing_parameters)
    end
  end

  # GET /cards/:id
  def show
    json_response(@card)
  end

  # PUT /cards/:id
  def update
    if @card.user_id == current_user.id
      @card.update(card_params_new)
      head :no_content
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_owner)
    end
  end

  # DELETE /cards/:id
  def destroy
    @list = List.find(@card.list_id)
    if (current_user.is_admin? && current_user.id == @list.created_by) || (current_user.is_member?(@list.id) && current_user.id == @card.user_id)
      @card.destroy
      head :no_content
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_owner)
    end
  end

  private


  def comment_params
    params.permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
