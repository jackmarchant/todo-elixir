defmodule Todo.Api do
  use Maru.Router
  alias Todo.AgentWorker, as: Store

namespace :tasks do
 desc "get all tasks"
  get do Store.get |> json
end

desc "creates a task"
  params do
  requires :description, type: String
  requires :completed, type: Boolean, default: false
end
post do Store.insert(params) |> json
end
  route_param :id do
   desc "get a task by id"
   get do
    Store.get(params[:id]) |> json
end

desc "updates a task"
 params do
  optional :completed, type: Boolean
  optional :description, type: String
  at_least_one_of [:completed, :description]
end
put do
  Store.update(params) |> json
end

 desc "deletes a task"
 delete do Store.delete(params[:id]) |> json
 end
 end
end

 def error(conn, _e) do
 %{error: _e} |> json
end
end