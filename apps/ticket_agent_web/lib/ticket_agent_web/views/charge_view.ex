defmodule TicketAgentWeb.ChargeView do
  use TicketAgentWeb, :view


  def render("create.json", %{stripe_response: stripe_response}) do
    %{
      stripe_response: stripe_response
    }
  end
    
  def render("create.json", %{}) do
    %{
      message: "ok"
    }
  end

  def render("error.json", %{code: code, reason: reason}) do
    %{
      code: code,
      reason: reason
    }
  end  

  def render("error.json", %{reason: reason}) do
    %{
      reason: reason
    }
  end  
end
