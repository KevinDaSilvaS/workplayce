defmodule Server.Integrations.Bookings do

  def get_booking(id) do
    Bookings.Repository.Bookings.get_one_booking(id)
  end

  def insert_booking(booking) do
    Bookings.Repository.Bookings.insert_booking(booking)
  end

  def update_booking(booking_data) do
    {id, booking} = Map.pop(booking_data, "id")
    Bookings.Repository.Bookings.update_booking(booking, id)
  end

  def delete_booking(id) do
    Bookings.Repository.Bookings.delete_booking(id)
  end
end
