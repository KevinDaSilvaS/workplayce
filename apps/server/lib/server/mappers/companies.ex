defmodule Server.Mappers.Companies do

  def validate_fields(fields) do
    schema = %{
      "company_name" => %Litmus.Type.String{
        required: true
      },
      "company_website" => %Litmus.Type.String{
        required: true
      },
      "email" => %Litmus.Type.String{
        required: true
      },
      "password" => %Litmus.Type.String{
        required: true
      },
      "max_offices" => %Litmus.Type.Number{
        required: true,
        default: 1
      },
      "confirmed_email" => %Litmus.Type.Bool{
        required: true,
        default: 1
      }
    }

    Litmus.validate(fields, schema)
  end

  def validate_update_fields(fields) do
    schema = %{
      "id" => %Litmus.Type.String{
        required: true
      },
      "company_name" => %Litmus.Type.String{
        required: false
      },
      "company_website" => %Litmus.Type.String{
        required: false
      },
      "email" => %Litmus.Type.String{
        required: false
      },
      "password" => %Litmus.Type.String{
        required: false
      },
      "max_offices" => %Litmus.Type.Number{
        required: false,
        default: 1
      },
      "confirmed_email" => %Litmus.Type.Bool{
        required: false,
        default: 1
      }
    }

    Litmus.validate(fields, schema)
  end
end
