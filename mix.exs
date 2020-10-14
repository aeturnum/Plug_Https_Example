defmodule MinimalPlugHttps.MixProject do
  use Mix.Project

  def project do
    [
      app: :minimal_plug_https,
      version: "0.1.0",
      # The Mix project has changed a bit over time, so 1.10 is a reasonable place, but
      # I don't think this project uses any features past Elixir 1.6 or so.
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # We don't actually use logger, but it's important to start because one of our dependencies might use it
      extra_applications: [:logger],
      # Include ourselves in the list of applications so our supervisor "tree" of one process
      # is started.
      mod: {MinimalPlugHttps, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Just the plug_cowboy dependency for us.
      {:plug_cowboy, "~> 2.4.0"}
      # This will actually get 9 libraries, many of them erlang:
      # Erlang:
      #   cowboy: The geat web server itself
      #   cowboy_telemetry: support library that handles telemetry (event reporting) for cowboy
      #   cowlib: support library that helps deal with the specifics of various protocols (websockets, http/2)
      #   ranch: Socket pool for TCP protocols
      #   telemetry: Underlying event reporting library used by cowboy_telemetry
      # Elixir:
      #   plug: Flexible request processing library that's at the heart of most Elixir web servers
      #   plug_cowboy: Interface for using cowboy with plug
      #   plug_crypto: Crypto portion of plug
      #   mime: Elixir library to help with mime typing
    ]
  end
end
