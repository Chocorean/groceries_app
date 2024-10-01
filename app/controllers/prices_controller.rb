# frozen_string_literal: true

# Controller for the prices of an item
class PricesController < ApplicationController
  before_action :load_items, only: %i[new create]

  def index
    @prices = Price.all
  end

  def new
    @price = Price.new(date: Time.zone.today)
  end

  def create
    @price = Price.new(price_params)

    if @price.save
      redirect_to new_price_path, notice: 'Price was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def price_params
    params.require(:price).permit(:item_id, :date, :value, :promo)
  end

  def load_items
    @items = Item.select(:id, :name)
  end
end
