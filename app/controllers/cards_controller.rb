#class CardsController < ApplicationController
#end

# app/controllers/cards_controller.rb
class CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]

  # GET /cards
  def index
    @cards = current_user.cards
    json_response(@cards)
  end

  # POST /cards
  def create
    if current_user.is_member?(card_params['list_id']) || current_user.is_admin?
      @list = List.find(card_params['list_id'])
      #@card = Card.create!(card_params)
      @card = @list.cards.new(card_params_new)
      @card.user_id = current_user.id
      @card.save
      json_response(@card, :created)
    else
      raise(ExceptionHandler::AuthenticationError, Message.unauthorized_not_member)
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

  def card_params
    # whitelist params
    params.permit(:title, :description , :list_id)
  end

  def card_params_new
    params.permit(:title, :description)
  end

  def set_card
    @card = Card.find(params[:id])
  end
end
