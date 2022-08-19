defmodule Server.Mappers.Bookings do

  def validate_fields(fields) do
    schema = %{
      "user_id" => %Litmus.Type.String{
        required: true
      },
      "place_id" => %Litmus.Type.String{
        required: true
      },
      "day" => %Litmus.Type.Number{
        required: true
      },
      "month" => %Litmus.Type.Number{
        required: true
      }
    }

    Litmus.validate(fields, schema)
  end

  def validate_update_fields(fields) do
    schema = %{
      "id" => %Litmus.Type.String{
        required: true
      },
      "approved" => %Litmus.Type.Boolean{
        required: false
      }
    }

    Litmus.validate(fields, schema)
  end
end
