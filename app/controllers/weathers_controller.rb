class WeathersController < ApplicationController
  before_action :set_weather, only: [:show, :edit, :update, :destroy]

  # GET /weathers
  # GET /weathers.json
  def index
    @weathers = Weather.all
  end

  # GET /weathers/1
  # GET /weathers/1.json
  def show
  end

  # GET /weathers/new
  def new
    @weather = Weather.new
    @event_id = params["event_id"]
  end

  # GET /weathers/1/edit
  def edit
  end

  # POST /weathers
  # POST /weathers.json
  def create
    puts params
    puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    @weather = Weather.new(weather_params)
    p "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"

    respond_to do |format|
      if @weather.save
        p @weather
        format.html { redirect_to root_path, notice: 'Weather task was successfully created.' }
        format.json { render :show, status: :created, location: @weather }
      else
        format.html { render :new }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weathers/1
  # PATCH/PUT /weathers/1.json
  def update
    respond_to do |format|
      if @weather.update(weather_params)
        format.html { redirect_to root_path, notice: 'Weather task was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather }
      else
        format.html { render :edit }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weathers/1
  # DELETE /weathers/1.json
  def destroy
    @weather.destroy
    respond_to do |format|
      format.html { redirect_to weathers_url, notice: 'Weather was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather
      @weather = Weather.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_params
      params.require(:weather).permit(:city, :state, :event_id)
    end
end
