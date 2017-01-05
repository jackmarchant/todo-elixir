defmodule Todo do
  use Application
  def start(_type, _args) do
    import Supervisor.Spec,
    warn: false
    children = [ worker(Todo.AgentWorker, []) ]
    opts = [strategy: :one_for_one, name: Todo.Supervisor]

    Supervisor.start_link(children, opts)
  end
end