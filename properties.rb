require_relative 'service_wrapper'
require 'json'
module EasyBroker
  class Properties
    LIMIT = 20
    def initialize(content:, page:, total:)
      @content = content
      @page = page
      @total = total
    end

    def self.get(page: 1)
      result = EasyBroker::ServiceWrapper.make_request(page: page, limit: LIMIT)
      parsed_result = JSON.parse(result)
      pagination = parsed_result['pagination']
      new(content: parsed_result['content'], page: pagination['page'], total: pagination['total'])
    rescue StandardError => _e
      'Something went wrong'
    end

    attr_reader :content, :page, :total
  end
end
