class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @where = "new"
  end

  # GET /events/1/edit
  def edit
    @where = "edit"
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id

    if params['order'] && params['order']['order_id'].present?
      @event.event_id = params['order']['order_id']
      @event.save
      redirect_to root_path, notice: 'Order was successfully created.'

    else
      respond_to do |format|
        if @event.save
          case @event.category
            when "Order"
              @order = Order.new
              format.html { redirect_to new_order_path(@order, :event_id => @event.id), notice: 'Event was successfully created.' }
              format.json { render :show, status: :created, location: @event }
            when "Nest"
              @nest = Nest.new
              format.html { redirect_to new_nest_path(@nest, :event_id => @event.id), notice: 'Event was successfully created.' }
              format.json { render :show, status: :created, location: @event }
            when "Weather"
              @weather = Weather.new(event_id: @event.id)
              @weather.save
              format.html { redirect_to new_weather_path(@weather, :event_id => @event.id), notice: 'Event was successfully created.' }
              format.json { render :show, status: :created, location: @event }
            else
              format.html { redirect_to @event, notice: 'Event was successfully created.' }
              format.json { render :show, status: :created, location: @event }
          end
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    end

    case params["repeat"]
    when "Daily"
      29.times do |events|
        @future = @event.dup
        @future.starts_at += 1.day
        @future.save
        @event = @future
      end
    when "Weekly"
      4.times do |events|
        @future = @event.dup
        @future.starts_at += 7.day
        @future.save
        @event = @future
      end
    else
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :category, :starts_at, :event_id, :condition)
    end
end
