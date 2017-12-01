defmodule TicketAgentWeb.AboutController do
  use TicketAgentWeb, :controller
  alias TicketAgent.{Repo, Teacher}
  import Ecto.Query

  @theater_description """
  The Push Comedy Theater is a 90 seat venue in the heart of Norfolk\'s brand new Arts District.  Founded by local comedy group The Pushers, the Push Comedy Theater is dedicated to bringing you live comedy from the best local and national acts.
  The Push Comedy Theater will host live sketch, improv and stand-up comedy on Friday and Saturday nights.  During the week classes will be offered in stand-up, sketch and improv comedy as well as acting and film production.
  Whether your a die-hard comedy lover or a casual fan... a seasoned performer or someone who's never stepped foot on stage... the Push Comedy Theater has something for you.  
  """

  @teachers Repo.all(Teacher)
  def index(conn, _params) do
    conn
    |> assign(:page_title, "About The Push Comedy Theater")
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(@theater_description, false))
    |> render("index.html", teachers: @teachers)
  end

  def show(conn, %{"id" => id}) do
    teacher = Repo.get_by(Teacher, [slug: id])

    conn
    |> assign(:page_title, teacher.name)
    |> assign(:page_description, TicketAgentWeb.LayoutView.open_graph_description(teacher.biography, false))
    |> assign(:page_image, "https://cdn.pushcomedytheater.com/images/#{teacher.slug}.jpg")
    |> render("show.html", teacher: teacher, teachers: @teachers)
  end
end
