defmodule Places.Repository.Places do
  def list_places(_filters) do
    [
      %{
        city: "Frankfurt",
        country: "Germany",
        address: "laker street 451",
        place_id: "123456",
        description: "view to the fukushima mountain office",
        links: ["flickrwithofficephotos"]
      },
      %{
        city: "Rio de Janeiro",
        country: "Brazil",
        address: "laker street 451",
        place_id: "123456",
        description: "view to the copacabana beach mountain office",
        links: ["flickrwithofficephotos"]
      },
      %{
        city: "Buenos Aires",
        country: "Argentina",
        address: "laker street 451",
        place_id: "123456",
        description: "confortable office with free food",
        links: ["flickrwithofficephotos"]
      }
    ]
  end

  def insert_place(place) do
    place
  end
end
