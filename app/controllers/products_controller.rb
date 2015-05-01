class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:destroy]

  # GET /products
  def index
    @products = Product.mine(current_user.id)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  # POST /products.json
  def create
    files = params[:files]
    files.each do |image|
      @product = Product.new({ image: image, user_id: current_user.id })
      @product.save
    end

    respond_to do |format|
      format.html { render :new }
    end
  end

  # DELETE /products/1
  def destroy
    if @product.user_id == current_user.id
      @product.destroy
    end

    respond_to do |format|
      format.html { redirect_to action: 'index' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:image, :image_cache, :remove_image)
    end
end
