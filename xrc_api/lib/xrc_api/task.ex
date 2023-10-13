defmodule XrcApi.Task do
  def work do
    # File.write("/tmp/quantum_phoenix.txt", "#{Timex.now}", [:append])
    IO.puts("Cron job executed -> #{Timex.now}")
  end
end