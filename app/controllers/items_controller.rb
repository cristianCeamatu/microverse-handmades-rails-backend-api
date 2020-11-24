class ItemsController < ApplicationController
  before_action :set_item, only: %i[show update destroy favorite]
  before_action :authenticate_api_user!, only: %i[update favorite destroy]

  # GET /items
  def index
    @items = Item.all.order('created_at DESC')

    render json: serialize_items(@items)
  end

  # GET /items/1
  def show
    render json: serialize_item(@item)
  end

  # POST /items
  def create
    @item = Item.new(item_params)

    if @item.save
      render json: serialize_item(@item), status: :created, location: @item
    else
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  def update
    if @item.update(item_params)
      render json: serialize_item(@item)
    else
      render json: @item.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy
    render json: serialize_item(@item)
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
      render json: { success: false, message: 'Provide a type (favorite/unfavorite)' }, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.permit(:user_id, :name, :description, :price, :ratings, :usedFor, :image)
  end

  def serialize_items(items)
    items.map { |item| serialize_item(item) }
  end

  def serialize_item(item)
    {
      id: item.id,
      name: item.name,
      description: item.description,
      price: item.price,
      usedFor: item.usedFor,
      ratings: item.ratings,
      image_url: item.image_url,
      created_at: item.created_at,
      updated_at: item.updated_at,
      user_id: item.user_id,
      user_name: item.user.name,
      favorited_by: item.favorited_by
    }
  end
end
