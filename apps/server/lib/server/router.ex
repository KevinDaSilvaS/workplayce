defmodule Server.Router do
  use Server, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Server do
    pipe_through :api

    resources "/places", PlacesController, only: [:index, :show, :create, :update, :delete]
    get "/places/companies/:company_id", PlacesController, :get_company_places
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] validate if max_offices == total offices before inserting a new

    resources "/places/availability/", AvailabilityController, only: [:show, :create, :update, :delete]
    get "/places/availability/:month/:place_id", AvailabilityController, :get_availability
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] validate place exists before creating availability

    resources "/bookings", BookingsController, only: [:show, :create, :update, :delete]
    get "/bookings/companies/:company_id", BookingsController, :get_company_bookings
    get "/bookings/users/:user_id", BookingsController, :get_user_bookings
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages
    #        [] validate availability/day exists before creating booking

    resources "/users", UsersController, only: [:show, :create, :update, :delete]
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages

    resources "/companies", CompaniesController, only: [:show, :create, :update, :delete]
    # ROUTES/MAIN RULES - OK - DONE
    # TODO - [] better error messages

    post "/users/auth/login", AuthController, :login_user

    post "/companies/auth/login", AuthController, :login_company

    get "/auth/", AuthController, :get_token_info

    #resources "/plans", PlacesController, only: [:index, :show, :create, :update, :delete]

    #resources "/ratings", PlacesController, only: [:index, :show, :create, :update, :delete]
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
