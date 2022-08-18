defmodule Server.Router do
  use Server, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Server do
    pipe_through :api

    resources "/places", PlacesController, only: [:index, :show, :create, :update, :delete]
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] add auth header validation
    #        [] validate if max_offices == total offices before inserting a new

    resources "/places/availability/", AvailabilityController, only: [:show, :create, :update, :delete]
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] validate place exists before creating availability
    #        [] add auth header validation?

    resources "/bookings", PlacesController, only: [:index, :show, :create, :update, :delete]
    #get "/bookings/:booking_id", PlacesController, :get_places

    resources "/users", UsersController, only: [:show, :create, :update, :delete]
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] add auth header validation?

    resources "/companies", CompaniesController, only: [:show, :create, :update, :delete]
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] add auth header validation

    resources "/plans", PlacesController, only: [:index, :show, :create, :update, :delete]

    resources "/ratings", PlacesController, only: [:index, :show, :create, :update, :delete]
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: Server.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
