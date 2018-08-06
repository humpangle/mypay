defmodule BurdaWeb.Router do
  use BurdaWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", BurdaWeb do
    pipe_through(:browser)

    get("/", IndexController, :index)

    resources("/shifts", ShiftController)
    resources("/metas", MetaController)
  end

  if Mix.env() == :dev do
    scope "/" do
      pipe_through(:api)

      forward(
        "/graphql",
        Absinthe.Plug.GraphiQL,
        schema: BurdaWeb.Schema,
        context: %{pubsub: BurdaWeb.Endpoint}
      )
    end
  end
end
