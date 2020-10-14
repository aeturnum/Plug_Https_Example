defmodule MinimalPlugHttps do
  use Application

  def init(:ok) do
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      {
        # First argument tell the supervisor to start the Cowboy module of Plug
        # using the https protocol (http requests will be redirected).
        # We also pass along our router module to handle requests
        Plug.Cowboy,
        scheme: :https,
        options: [
          # standard https port - will require running as root!
          port: 443,
          # Replace with the paths to your certs!
          certfile: "/etc/letsencrypt/[...]/cert.pem",
          keyfile: "/etc/letsencrypt/[...]/privkey.pem",
          cacertfile: "/etc/letsencrypt/[...]/chain.pem"
        ],
        plug: MinimalPlugHttps.Router
      }
    ]

    opts = [strategy: :one_for_one, name: MinimalPlugHttps.Supervisor]
    # This will start
    Supervisor.start_link(children, opts)
  end
end
