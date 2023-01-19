module RequestSpecHelper
  def response_as_json
    JSON.parse(response.body, symbolize_names: true)
  end
end
