class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :authenticate_api_user!, only: %i[create update favorite destroy]

  # GET /items
  def index
    @items = Item.all

    render json: @items.to_json(include: %i[user favorited_by])
  end

  # GET /items/1
  def show
    render json: @items.to_json(include: %i[user favorited_by])
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item, status: :created, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
  end

  def favorite
    type = params[:type]
    if type == 'favorite'
      current_api_user.favorites << @recipe
      render json: {success: true, message: "You favorited #{@recipe.name}" }

    elsif type == 'unfavorite'
      current_api_user.favorites.delete(@recipe)
      render json: { success: true, message: "Unfavorited #{@recipe.name}" }

    else
      # Type missing, nothing happens
      render json: { success: false, message: "Type of request is missing (favorite/unfavorite)" }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:user_id, :name, :description, :price, :ratings, :material, :usedFor)
    end
end
