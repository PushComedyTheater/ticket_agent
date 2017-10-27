defmodule TicketAgentWeb.AboutController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, Teacher}
  import Ecto.Query

  def index(conn, _params) do
    teachers = Repo.all(Teacher)
    render conn, "index.html", teachers: teachers
  end

  def show(conn, %{"id" => id}) do
    teachers = Repo.all(Teacher)
    teacher = Repo.get_by(Teacher, [slug: id])
    render conn, "show.html", pusher: teacher, teachers: teachers
  end
end
