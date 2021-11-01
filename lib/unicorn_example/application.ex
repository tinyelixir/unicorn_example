defmodule UnicornExample.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    initialize_data_directory()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UnicornExample.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: UnicornExample.Worker.start_link(arg)
        # {UnicornExample.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: UnicornExample.Worker.start_link(arg)
      # {UnicornExample.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: UnicornExample.Worker.start_link(arg)
      # {UnicornExample.Worker, arg},
    ]
  end

  defp initialize_data_directory() do
    destination_dir = "/data/livebook"
    source_dir = Application.app_dir(:unicorn_example, "priv")

    # Best effort create everything
    _ = File.mkdir_p(destination_dir)
    Enum.each(["welcome.livemd", "samples"], &symlink(source_dir, destination_dir, &1))
  end

  defp symlink(source_dir, destination_dir, filename) do
    source = Path.join(source_dir, filename)
    dest = Path.join(destination_dir, filename)

    _ = File.rm(dest)
    _ = File.ln_s(source, dest)
  end

  def target() do
    Application.get_env(:unicorn_example, :target)
  end
end
