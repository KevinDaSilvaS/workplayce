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
        required: false
      },
      "confirmed_email" => %Litmus.Type.Boolean{
        required: false
      }
    }

    Litmus.validate(fields, schema)
  end
end
