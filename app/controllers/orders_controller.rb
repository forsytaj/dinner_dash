class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authorized_for_admin?, only: [:edit, :update, :destroy]
  before_action :authorize, only: [:index, :new, :create, :show]

  # GET /orders
  # GET /orders.json
  def index
    @orders = is_admin? ? Order.all : current_user.orders
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = current_user.orders.build
    @order = current_cart.item_ids
    if @order.save
      current_cart.empty!
      redirect_to order_path(@order), notice: "Your order has been created. It will be ready for pickup in x minutes."
    else 
      redirect_to cart_path, error: "Order could not be created."
    end 
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params[:order].permit!
    end
    
    def authorize
      if !user_signed_in?
        session[:return_to] = request.path
        redirect_to signin_path, notice: "You must log in before placing an order." unless user_signed_in?
      end 
    end 
end
