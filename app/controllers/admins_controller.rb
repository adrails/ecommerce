class AdminsController < ApplicationController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  # GET /admins
  # GET /admins.json
  def index
    @users = User.all
  end

  # GET /admins/1
  # GET /admins/1.json
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
  end

  # GET /admins/1/edit
  def edit
  end

  # POST /admins
  # POST /admins.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to @admin, notice: 'Admin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admins/1
  # PATCH/PUT /admins/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to @admin, notice: 'Admin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admins/1
  # DELETE /admins/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admins_url }
      format.json { head :no_content }
    end
  end
	
	def retailer_requests
		@users = User.find_all_by_role_type_and_retailer_approval("RETAILER",false)
	end

	def approve_and_reject_retailer
		@user = User.find_by_id(params[:id])
		if params[:approval] = "Yes"
			@user.retailer_approval = true
			@user.confirmed_at = nil
			@pwd = (0..10).map { ('A'..'Z').to_a[rand(26)] }.join
			@user.password = @pwd
			@user.password_confirmation = @pwd
			@user.send_confirmation_instructions
			@user.save
			flash[:notice] = "Request Approved Successfully!!"
		elsif params[:approval] = "No"
			flash[:notice] = "Request Rejected Successfully!!"
		end
		redirect_to retailer_requests_admins_path
	end 
	
	def assign
		@categories = ProductCategory.all
		@brands = ProductBrand.all
		@products = ProductItem.all
	end
	
	def assign_item
		@product_item = ProductItem.find(params[:Product].to_i)
		if params[:Brand]
			@product_item.product_brand_id=params[:Brand].to_i
			@product_item.save
			flash[:notice] = "Product assigned to brand successfully!"
		elsif params[:Category]
			@product_item.product_category_id=params[:Category].to_i
			@product_item.save
			flash[:notice] = "Product assigned to category successfully!"
		end
		redirect_to product_items_path
	end
	
	def product_approval
		@products = ProductItem.find_all_by_is_active(false)
	end
	
	def approve_and_reject_product
		@product = ProductItem.find_by_id(params[:id])
		if params[:approval] = "Yes"
			@product.is_active = true
			@product.save
			Notifier.convey_appoval_to_retailer(@product).deliver
			flash[:notice] = "Request Approved Successfully!!"
		elsif params[:approval] = "No"
			@product.is_active = nil
			@product.save
			Notifier.convey_reject_to_retailer(@product).deliver
			flash[:notice] = "Request Rejected Successfully!!"
		end
		redirect_to product_approval_admins_path
	end
	
	def get_role_type
		p params
		p "##############"
		@users = User.find_all_by_role_type(params[:role])
		p @users.count
	end
	
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_params
      params[:admin]
    end
end
