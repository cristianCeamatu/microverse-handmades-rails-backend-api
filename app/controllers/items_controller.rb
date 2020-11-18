class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy favorite]
  before_action :authenticate_api_user!, only: %i[update favorite destroy]

  # GET /items
  def index
    @items = Item.all.order('created_at DESC')

    render json: @items.to_json(include: %i[user favorited_by image])
  end

  # GET /items/1
  def show
    render json: @item.to_json(include: %i[user favorited_by image])
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item.to_json(include: %i[user favorited_by image]), status: :created, location: @item
    else
      p @item.errors.full_messages
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: @item.to_json(include: %i[user favorited_by image])
    else
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    render json: @item.to_json(include: %i[user favorited_by image])
  end

  # POST /items/1/favorite
  def favorite
    type = params[:type]
    if type == 'favorite'
      current_api_user.favorites << @item unless current_api_user.favorites.include? @item
      render json: { success: true, message: "You favorited #{@item.name}" }

    elsif type == 'unfavorite'
      current_api_user.favorites.delete(@item) if current_api_user.favorites.include? @item
      render json: { success: true, message: "Unfavorited #{@item.name}" }

    else
      # Type missing, nothing happens
      render json: { success: false, message: 'Provide a type (favorite/unfavorite)' }, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def item_params
    params.permit(:user_id, :name, :description, :price, :ratings, :usedFor, :image)
  end
end
