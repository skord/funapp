require 'net/https'
require 'uri'
require 'json'

class BingSearch
  def self.search(term)
    uri = "https://api.cognitive.microsoft.com"
    path = "/bing/v7.0/images/search"
    uri = URI(uri + path + "?q=" + URI.escape(term))
    request = Net::HTTP::Get.new(uri)
    request['Ocp-Apim-Subscription-Key'] = ENV["BING_API_KEY"] 
    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end
    JSON.parse(response.body)
  end
  def self.get_image_url(term)
    res = search(term)
    if res["value"].blank?
      {thumbnail_url: nil, image_url: nil}
    else
      res = res['value'][0]
      {thumbnail_url: res['thumbnailUrl'], image_url: res["contentUrl"]}
    end
  end
end
