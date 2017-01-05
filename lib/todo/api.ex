defmodule Todo.Api do
  use Maru.Router

  namespace :tasks do

      desc "get all tasks"
        get do Todo.AgentWorker.get |> json
      end

      desc "creates a task"
      params do
        requires :description, type: String
        requires :completed, type: Boolean, default: false
      end

      post do Todo.AgentWorker.insert(params) |> json
      end

      route_param :id do
       desc "get a task by id"
       get do
        Todo.AgentWorker.get(params[:id]) |> json
      end

      desc "updates a task"
       params do
        optional :completed, type: Boolean
        optional :description, type: String
        at_least_one_of [:completed, :description]
      end

      put do
        Todo.AgentWorker.update(params) |> json
      end

      desc "deletes a task"
       delete do
        Todo.AgentWorker.delete(params[:id]) |> json
      end
    end
  end

  def error(conn, e) do
   %{error: e} |> json
  end
end