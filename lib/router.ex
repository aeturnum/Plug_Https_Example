defmodule MinimalPlugHttps.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  get "/" do
    # Hello world over https
    Plug.Conn.send_resp(conn, 200, "Hello HTTPs")
  end

  match _ do
    # answer any other request with a 404 to avoid getting log spam from exploit fishers
    Plug.Conn.send_resp(conn, 404, "File Not Found")
  end
end
