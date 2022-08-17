defmodule Server.Mappers.Users do
  def validate_fields(fields) do
    schema = %{
      "username" => %Litmus.Type.String{
        required: true
      },
      "description" => %Litmus.Type.String{
        required: false
      },
      "email" => %Litmus.Type.String{
        required: true
      },
      "password" => %Litmus.Type.String{
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
      "username" => %Litmus.Type.String{
        required: false
      },
      "description" => %Litmus.Type.String{
        required: false
      },
      "password" => %Litmus.Type.String{
        required: false
      },
      "confirmed_email" => %Litmus.Type.Boolean{
        required: false
      }
    }

    Litmus.validate(fields, schema)
  end
end
