module ApplicationHelper
  def asset_path(path)
    ENV.fetch('BACKEND_URL', nil) + path
  end
end
