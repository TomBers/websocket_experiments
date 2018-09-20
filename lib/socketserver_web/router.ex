defmodule SocketserverWeb.Router do
  use SocketserverWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SocketserverWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/print", PageController, :print
  end

  # Other scopes may use custom stacks.
  # scope "/api", SocketserverWeb do
  #   pipe_through :api
  # end
end
