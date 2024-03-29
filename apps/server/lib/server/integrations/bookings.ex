defmodule Server.Integrations.Bookings do

  def total_bookings(query) do
    Bookings.Repository.Bookings.total_bookings(query)
  end

  def get_booking(id) do
    Bookings.Repository.Bookings.get_one_booking(id)
  end

  def get_bookings(filters, opts) do
    Bookings.Repository.Bookings.list_bookings(filters, opts)
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
