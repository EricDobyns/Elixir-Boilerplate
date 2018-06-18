defmodule MyApi.AuthErrorHandler do
  import Plug.Conn

  def auth_error(conn, {type, _reason}, _opts) do
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(401, Poison.encode!(%{error: to_string(type)}))
  end

end
