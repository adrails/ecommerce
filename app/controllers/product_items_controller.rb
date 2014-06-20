require 'will_paginate/array'
class ProductItemsController < ApplicationController
  before_action :set_product_item, only: [:show, :edit, :update, :destroy]

  # GET /product_items
  # GET /product_items.json
  def index
		if User.find_role?(current_user) == "A"
			@product_items = ProductItem.all.paginate(:page => params[:page], :per_page => 4)
		elsif User.find_role?(current_user) == "B"
			@product_items = current_user.product_items.paginate(:page => params[:page], :per_page => 4)
		else
			@product_items = ProductItem.find_all_by_is_active(true).paginate(:page => params[:page], :per_page => 4)
		#	@products = @product_items.paginate(:page => params[:page], :per_page => 4)
		end
  end

  # GET /product_items/1
  # GET /product_items/1.json
  def show
  end

  # GET /product_items/new
  def new
    @product_item = ProductItem.new
  end

  # GET /product_items/1/edit
  def edit
  end

  # POST /product_items
  # POST /product_items.json
  def create
    @product_item = ProductItem.new(product_item_params)
		@product_item.user_id = current_user.id
		@product_item.is_active = User.find_role?(current_user) == "A" ? true : false
    respond_to do |format|
      if @product_item.save
				if params[:images]
					params[:images].each { |image|
						@product_item.pictures.create(image: image)
					}
				end
				if !User.find_role?(current_user) == "A"
					Notifier.send_product_create_notification(@product_item).deliver
				end
        format.html { redirect_to product_items_path, notice: 'Product item was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_item }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_items/1
  # PATCH/PUT /product_items/1.json
  def update
    respond_to do |format|
      if @product_item.update(product_item_params)
				if params[:images]
					params[:images].each { |image|
						@product_item.pictures.create(image: image)
					}
				end
        format.html { redirect_to product_items_path, notice: 'Product item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_items/1
  # DELETE /product_items/1.json
  def destroy
    @product_item.destroy
    respond_to do |format|
      format.html { redirect_to product_items_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_item
      @product_item = ProductItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_item_params
      params.require(:product_item).permit(:title, :available_quantity, :description, :price, :user_id, :is_active)
    end
end
