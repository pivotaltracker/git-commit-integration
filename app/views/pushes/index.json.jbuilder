json.array!(@pushes) do |push|
  json.extract! push, :id, :commits_processed, :repo_id, :payload, :ref, :head_commit
  json.url push_url(push, format: :json)
end
