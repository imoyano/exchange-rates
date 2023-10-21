defmodule XrcApiWeb.CalculatorController do
  use XrcApiWeb, :controller

  def index(conn, _params) do
    options = [
      {"ARS","Argentine Peso"},
      {"BOB","Bolivian Boliviano"},
      {"CLP","Chilean Peso"},
      {"COP","Colombian Peso"},
      {"EUR","Euro"},
      {"MXN","Mexican Peso"},
      {"PEN","Sol Peruvian"},
      {"USD","United States dollar"},
      {"UYU","Peso Uruguayo"}
    ]
    render(conn, "index.html", options: options)
  end
end
