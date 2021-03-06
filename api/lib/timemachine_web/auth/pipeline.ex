defmodule TimemachineWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :timemachine,
    error_handler: TimemachineWeb.Auth.ErrorHandler,
    module: TimemachineWeb.Auth.Guardian

  # If there is a session token, validate it
  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}

  # If there is an authorization header, validate it
  plug Guardian.Plug.VerifyHeader,
    claims: %{"typ" => "access"},
    refresh_from_cookie: true,
    halt: false

  # Load the user if either of the verifications worked
  plug Guardian.Plug.LoadResource, allow_blank: true
end
