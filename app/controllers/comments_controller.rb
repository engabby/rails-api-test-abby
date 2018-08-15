class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :update, :destroy]

  # GET /comments
  def index
    if(params.has_key?(:card_id))
      if(params.has_key?(:page) && params.has_key?(:per_page))
        @comments = Comment.where(card_id: params['card_id']).paginate(page: params[:page], per_page: params[:per_page])
        json_response(@comments)
      else
        @comments = Comment.where(card_id: params['card_id'])
        json_response(@comments)
      end

    elsif (params.has_key?(:comment_id))
      if(params.has_key?(:page) && params.has_key?(:per_page))
        @comments = Comment.where(parent_id: params['comment_id']).paginate(page: params[:page], per_page: params[:per_page])
        json_response(@comments)
      else
        @comments = Comment.where(parent_id: params['comment_id'])
        json_response(@comments)
      end
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

  # GET /comments/:id
  def show
    render json: @comment, include: :replies
  end

  # PUT /comments/:id
  def update
    if @comment.user_id == current_user.id
      @comment.update(comment_params)
      head :no_content
    else
      raise(ExceptionHandler::AuthenticationError, Message.invalid_owner)
    end
  end

  # DELETE /comments/:id
  def destroy
    @card = Card.find(@comment.card_id)
    if (current_user.is_admin? && current_user.id == @card.list.created_by) || (current_user.is_member?(@card.list_id) && current_user.id == @comment.user_id)
      @comment.destroy
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
