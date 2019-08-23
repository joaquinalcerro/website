defmodule ErlefWeb.GrantController do
  use ErlefWeb, :controller
  action_fallback ErlefWeb.FallbackController

  def index(conn, _params) do
    render(conn)
  end

  def create(conn, params) do
    # TODO: Validation
    proposal = Erlef.GrantProposal.from_map(params)
    Erlef.GrantMail.submission(proposal) |> Erlef.Mailer.send()
    Erlef.GrantMail.submission_copy(proposal) |> Erlef.Mailer.send()

    conn
    |> put_status(201)
    |> json(%{success: true})
  end
end
