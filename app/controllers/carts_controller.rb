class CartsController < ApplicationController
  before_action :set_cart, only: [:show, :edit, :update, :destroy]
	skip_before_filter :verify_authenticity_token, :only => [:get_quantity]
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

		@new_product_id = params[:product_item_ids].to_i
		@products_ids = @cart.product_item_ids
	
		if @cart.quantity.nil?
			@cart.quantity = [{"product_id"=>@new_product_id, "quantity"=>1}]
		else
			@cart.quantity.append({"product_id"=>@new_product_id, "quantity"=>1})
		end
		
		if @cart.total.nil?
			@cart.total = ProductItem.find(@new_product_id).price
		else
			if ([@new_product_id]-@products_ids).empty? || @products_ids.nil?
				@cart.total = @cart.total
			else
				@cart.total = @cart.total+ProductItem.find(@new_product_id).price
			end
		end
		
		if @products_ids.nil?
			@cart.product_item_ids = [@new_product_id]
		else
			@cart.product_item_ids = [@products_ids,@new_product_id].flatten.uniq
		end
		
		respond_to do |format|
      if @cart.save
				p "Save condn"
				p @new_product_id
				p @products_ids
				if !@products_ids.nil?
					if ([@new_product_id]-@products_ids).empty? 
						flash[:notice] = "Already present in your Cart!!"
					end
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
		@rejected = @cart.quantity.reject{|h| params[:product_id].to_i == h["product_id"] }
		@cart.quantity = @rejected
		if !@cart.total.nil?
			@cart.total = @cart.total-(ProductItem.find(params[:product_id].to_i).price)
		else
			@cart.total = nil
		end
		respond_to do |format|
      if @cart.save
				if @cart.product_item_ids.empty?
					@cart.total =nil
					@cart.save
				end
        format.html { redirect_to carts_path, notice: 'Cart was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
	end
	
	def get_quantity
		@cart = Cart.find_by_user_id(current_user.id)
		@cart.total = params[:total_price]
		if @cart.quantity.nil?
			@cart.quantity = [{"product"=>params[:product_id], "quantity"=>params[:quantity]}]
		else
			@cart.quantity && @cart.quantity.each do |f|
				if f.values[0] == params[:product_id].to_i
					f["quantity"] = params[:quantity]
				end
			end

		end
		
		respond_to do |format|
      if @cart.save
        #~ format.html { redirect_to carts_path, notice: 'Cart was successfully updated.' }
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
