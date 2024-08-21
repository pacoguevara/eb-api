require 'fakeweb'
require_relative '../service_wrapper'
require_relative 'eb_response'

describe EasyBroker::ServiceWrapper do
  let(:eb_response) { EB_RESPONSE }

  let(:url) { URI("https://api.stagingeb.com/v1/properties?page=1&limit=5") }

  subject { described_class.make_request(page: 1, limit: 5) }

  describe '.make request' do
    before(:each) do
      FakeWeb.register_uri(:get, url, :body => eb_response)
    end
    it 'should call to the api and get a response' do
      expect(subject).to include('content')
      expect(subject).to include('pagination')
    end
  end
end