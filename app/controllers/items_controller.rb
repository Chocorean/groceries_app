# frozen_string_literal: true

# Controller for products
class ItemsController < ApplicationController
  before_action :load_data, only: %i[new create]

  def index
    @items = Item.all

    render json: @items.map { |item| { value: item.id, text: item.name } }
  end

  def show
    @item = Item.find(params[:id])
    render json: { name: @item.name, prices: @item.prices.select(:date, :value).order(:date).limit(10) }
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    price = price_params[:price]

    if @item.save
      if price_params[:price]
        p = Price.new(value: price, date: Time.zone.now, item: @item)
        if p.save
          redirect_to new_item_path, notice: "Item #{@item.name} and price were successfully created."
        else
          redirect_to new_item_path,
                      notice: "Item #{@item.name} was successfully created, but price could not be saved."
        end
      else
        redirect_to new_item_path, notice: "Item #{@item.name} was successfully created."
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    params.require(:item).permit(%i[name weight store_id unit_id])
  end

  def price_params
    params.permit(:price)
  end

  # @stores is for a datalist, @units for a select's options, thus the difference of order
  def load_data
    @items = Item.select(:name)
    @stores = Store.select(:id, :name)
    @units = Unit.select(:id, :name).map { |unit| [unit.name, unit.id] }
  end
end
