defmodule Companies.Repository.Companies do
  def list_companies(filters, opts) do
    Mongo.find(Mongo.Companies, "companies", filters, opts)
    |> Enum.to_list()
    |> Enum.map(fn company ->
      Map.put(company, "_id", BSON.ObjectId.encode!(company["_id"]))
    end)
  end

  def insert_company(company) do
    {:ok, insertedOneResult} = Mongo.insert_one(Mongo.Companies, "companies", company)

    %{"inserted_id" => BSON.ObjectId.encode!(insertedOneResult.inserted_id)}
  end

  def get_one_company(%{"email" => company_email}) do
    company = Mongo.find_one(Mongo.Companies, "companies", company_email)
    case company do
      nil -> nil
      _ -> Map.put(company, "_id", BSON.ObjectId.encode!(company["_id"]))
    end
  end
  def get_one_company(company_id) do
    company_id = BSON.ObjectId.decode!(company_id)
    company = Mongo.find_one(Mongo.Companies, "companies", %{"_id" => company_id})
    case company do
      nil -> nil
      _ -> Map.put(company, "_id", BSON.ObjectId.encode!(company["_id"]))
    end
  end

  def login(email, password) do
    company = Mongo.find_one(Mongo.Companies, "companies", %{
      "email" => email,
      "password" => password
    })
    case company do
      nil -> nil
      _ -> Map.put(company, "_id", BSON.ObjectId.encode!(company["_id"]))
    end
  end

  def update_company(replace_data, company_id) do
    company_id = BSON.ObjectId.decode!(company_id)

    Mongo.find_one_and_update(
      Mongo.Companies,
      "companies",
      %{"_id" => company_id},
      %{"$set": replace_data})
  end

  def delete_company(company_id) do
    company_id = BSON.ObjectId.decode!(company_id)

    Mongo.find_one_and_delete(
      Mongo.Companies,
      "companies",
      %{"_id" => company_id})
  end
end
