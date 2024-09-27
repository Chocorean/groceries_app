# frozen_string_literal: true

# Controller for products
class ItemsController < ApplicationController
  def index
    @items = Item.all

    render json: @items.map { |item| { value: item.id, text: item.name } }
  end

  def show
    @item = Item.find(params[:id])
    render json: { name: @item.name, prices: @item.prices.select(:date, :value).order(:date).limit(10) }
  end

  # method used by the search bar to find items by name
  def search
    items = Item.where('name LIKE ?', "%#{params[:q]}%").select(:id, :name).limit(5)
    # add prices if the search returns only one item
    if items.length == 1
      item = items.first
      render json: [{ id: item.id, name: item.name, prices: item.prices.order(:date).limit(10) }]
    else
      render json: items
    end
  end
end
