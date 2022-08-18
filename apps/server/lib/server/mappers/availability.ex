defmodule Server.Mappers.Availability do
  def validate_fields(fields) do
    schema = %{
      "days_available" => %Litmus.Type.List{
        required: true,
        type: :number
      },
      "place_id" => %Litmus.Type.String{
        required: true
      },
      "month_number" => %Litmus.Type.Number{
        required: true
      },
      "available_spots" => %Litmus.Type.Number{
        required: true
      }
      #"price" => %Litmus.Type.Number{
        #required: true
      #}
    }

    Litmus.validate(fields, schema)
  end

  def validate_update_fields(fields) do
    schema = %{
      "id" => %Litmus.Type.String{
        required: true
      },
      "days_available" => %Litmus.Type.List{
        required: false,
        type: :number
      },
      "place_id" => %Litmus.Type.String{
        required: false
      },
      "month_number" => %Litmus.Type.Number{
        required: false
      },
      "available_spots" => %Litmus.Type.Number{
        required: false
      }
    }

    Litmus.validate(fields, schema)
  end
end
