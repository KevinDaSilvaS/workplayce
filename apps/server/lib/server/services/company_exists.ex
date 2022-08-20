defmodule Server.Services.CompanyExists do
  def company_exists?(email) do
    companyFound = Server.Integrations.Companies.get_company(%{"email" => email})

    case companyFound do
      nil -> false
      _ -> true
    end
  end
end
