class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  before_action :set_restaurant, :except => [:destroy, :me]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = @restaurant.reservations
  end

  def me
    @reservations = Reservation.myReservations(current_user.id)
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = @restaurant.reservations.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        format.html { redirect_to [@restaurant, @reservation], notice: 'Reserva creada correctamente.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to [@restaurant, @reservation], notice: 'Photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      if user_signed_in? and current_user.role = 1
        format.html { redirect_to '/reservations/me', notice: 'Reserva cancelada correctamente.'}
      else
        format.html { redirect_to restaurant_reservations_path, notice: 'Reserva destruida correctamente.' }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:date, :description, :personCount, :user_id)
    end
end
