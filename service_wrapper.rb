require 'uri'
require 'net/http'

module EasyBroker
  class ServiceWrapper
    def self.make_request(page:, limit:)
      url = URI("https://api.stagingeb.com/v1/properties?page=#{page}&limit=#{limit}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["accept"] = 'application/json'
      request["X-Authorization"] = 'l7u502p8v46ba3ppgvj5y2aad50lb9' # I'd put this in a secret.yml or similar

      response = http.request(request)
      response.read_body
    end
  end
end
