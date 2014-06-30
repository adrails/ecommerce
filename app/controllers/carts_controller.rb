class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]

  # GET /carts
  # GET /carts.json
  def index
    @cart = current_user.cart
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @cart = Cart.new
  end

  # GET /carts/1/edit
  def edit
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(cart_params)
		@cart.user_id = current_user.id
		@cart.product_item_ids = param[:product_item_ids]
    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cart }
      else
        format.html { render action: 'new' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /carts/1
  # PATCH/PUT /carts/1.json
  def update
    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart.destroy
    respond_to do |format|
      format.html { redirect_to carts_url }
      format.json { head :no_content }
    end
  end

	def my_cart
		@cart = Cart.find_by_user_id(params[:user_id])
		@products_ids = @cart.product_item_ids
		@new_product_id = params[:product_item_ids].to_i
		if @products_ids.nil?
			@cart.product_item_ids = [@new_product_id]
		else
			@cart.product_item_ids = [@products_ids,@new_product_id].flatten.uniq
		end
		respond_to do |format|
      if @cart.save
				if ([@new_product_id]-@products_ids).empty?
					flash[:notice] = "Already present in your Cart!!"
				else
					flash[:notice] = "Cart was successfully updated."
				end
        format.html { redirect_to carts_path}
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
	end
	
	def remove_from_my_cart
		@cart = Cart.find_by_user_id(current_user.id)
		@cart.product_item_ids.delete(params[:product_id].to_i)
		p @cart.product_item_ids
		respond_to do |format|
      if @cart.save
        format.html { redirect_to carts_path, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cart_params
      params.require(:cart).permit(:user_id, :product_item_ids)
    end
end
