class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @event_id = params["event_id"]
  end

  # GET /orders/1/edit
  def edit
  end

  def confirm
    order = Order.where(:access => params[:id])
    if (order.length != 0)
      @order = order[0]
      @order.confirmation = true
      @order.save
      respond_to do |format|
        format.html { redirect_to @order, notice: 'Order was confirmed!' }
        format.json { render :show, status: :created, location: @order }
      end
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    if params[:commit] == 'Order Nearby'
      order_nearby
      render :new
    else
      params["order"]["access"] = Digest::SHA1.base64digest((Order.count + 1).to_s)
      @order = Order.new(order_params)
      puts @order.access
      puts @order.confirmation
      respond_to do |format|
        if @order.save
          format.html { redirect_to calendars_path, notice: 'Order was successfully created.' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def order_nearby
    pickup_name = params['pickup_name']
    puts request.remote_ip
    location = Geocoder.search(request.remote_ip).first
    p location
    # @pickup_name = 'Starbucks'
    # location = Geocoder.search('158.130.108.92').first
    lat = location.data['latitude']
    lon = location.data['longitude']
    dropoff_name = current_user.name
    dropoff_address = Geocoder.search([lat, lon]).first.data['formatted_address']
    dropoff_phone_number = current_user.phone

    yelp_params = {term: @pickup_name}
    coordinates = {latitude: lat, longitude: lon}
    results = Yelp.client.search_by_coordinates(coordinates, yelp_params).businesses.select {|place| place.has_key?(:phone)}
    result = results.min_by { |place| place.distance}
    pickup_address = result.location.display_address.join(', ')
    pickup_phone_number = result.phone.last(10)
    @order = Order.new(object_params)
    @order.assign_attributes({pickup_name: pickup_name, dropoff_name: dropoff_name,
        dropoff_address: dropoff_address, dropoff_phone_number: dropoff_phone_number,
        pickup_address: pickup_address, pickup_phone_number: pickup_phone_number})
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:event_id, :confirmation, :access, :manifest, :pickup_name, :pickup_address, :pickup_phone_number, :pickup_business_name, :pickup_notes, :dropoff_name, :dropoff_address, :dropoff_phone_number, :dropoff_business_name, :dropoff_notes, :quote_id)
    end

    def distance_from_me(place)

    end
end
