class ProfileDetailsController < ApplicationController
  before_action :set_profile_detail, only: [:show, :edit, :update, :destroy]

  # GET /profile_details
  # GET /profile_details.json
  def index
    @profile_details = ProfileDetail.all
  end

  # GET /profile_details/1
  # GET /profile_details/1.json
  def show
  end

  # GET /profile_details/new
  def new
    @profile_detail = ProfileDetail.new
		#~ 2.times do
			#~ address = @profile_detail.addresses.build
		#~ end
  end

  # GET /profile_details/1/edit
  def edit
		#~ 2.times do
			#~ address = @profile_detail.addresses.build
		#~ end
  end

  # POST /profile_details
  # POST /profile_details.json
  def create
    @profile_detail = ProfileDetail.new(profile_detail_params)
		@profile_detail.user_id = current_user.id
    respond_to do |format|
      if @profile_detail.save
        format.html { redirect_to edit_profile_detail_path(@profile_detail), notice: 'Profile detail was successfully created.' }
        format.json { render action: 'show', status: :created, location: @profile_detail }
      else
        format.html { render action: 'new' }
        format.json { render json: @profile_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_details/1
  # PATCH/PUT /profile_details/1.json
  def update
    respond_to do |format|
      if @profile_detail.update(profile_detail_params)
        format.html { redirect_to edit_profile_detail_path(@profile_detail), notice: 'Profile detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @profile_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_details/1
  # DELETE /profile_details/1.json
  def destroy
    @profile_detail.destroy
    respond_to do |format|
      format.html { redirect_to profile_details_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_detail
      @profile_detail = ProfileDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_detail_params
      params[:profile_detail]
    end
end
