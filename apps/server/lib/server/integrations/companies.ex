defmodule Server.Integrations.Companies do
  def get_companies(filters, opts) do
    Companies.Repository.Companies.list_companies(filters, opts)
  end

  def get_company(id) do
    Companies.Repository.Companies.get_one_company(id)
  end

  def login(email, password) do
    Users.Repository.Users.login(email, password)
  end

  def insert_company(company) do
    Companies.Repository.Companies.insert_company(company)
  end

  def update_company(company_data) do
    {id, company} = Map.pop(company_data, "id")
    Companies.Repository.Companies.update_company(company, id)
  end

  def delete_company(id) do
    Companies.Repository.Companies.delete_company(id)
  end
end
