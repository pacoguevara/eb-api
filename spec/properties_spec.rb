require_relative '../properties'
require_relative 'eb_response'

describe EasyBroker::Properties do
  let(:eb_response) { EB_RESPONSE }

  describe '.get' do
    context 'with a successful response' do
      before(:each) do
        allow(EasyBroker::ServiceWrapper).to receive(:make_request).and_return(eb_response)
      end

      subject { described_class.get }
      it 'returns a list of properties' do
        expect(subject.content.size).to eq(5)
        expect(subject.page).to eq(1)
      end
    end

    context 'when something went wrong with the service' do
      before(:each) do
        allow(EasyBroker::ServiceWrapper).to receive(:make_request).and_throw(StandardError)
      end

      subject { described_class.get(page: 1) }

      it 'catch the exception and return an error message' do
        expect(subject).to eq('Something went wrong')
      end
    end
  end

  describe '.get_titles' do
    it 'returns a list of titles' do
      expect(described_class.get_titles).to include('Casa bien bonita',
                                                         'Bodega en Naucalpan',
                                                         'Casa en Renta en Residencial Privada Jardín, Juárez, N.L.',
                                                         'Casa en Renta en Col. Obrerista en Monterrey, N.L.',
                                                         'Casa en Venta en Nuevo Amanecer en Apodaca, N.L.')
    end

    context 'when something went wrong with the service' do
      before(:each) do
        allow(EasyBroker::ServiceWrapper).to receive(:make_request).and_throw(StandardError)
      end

      subject { described_class.get_titles }

      it 'catch the exception and return an error message' do
        expect(subject).to eq('Something went wrong')
      end
    end
  end

  describe '#titles' do
    let(:parsed_response) { JSON.parse(eb_response) }
    let(:pagination) { parsed_response['pagination'] }
    let(:property_collection) do
      described_class.new(content: parsed_response['content'], page: pagination['page'], total: pagination['total'])
    end

    it 'returns a list with all the titles' do
      expect(property_collection.list_titles).to include('Casa bien bonita',
                                                         'Bodega en Naucalpan',
                                                         'Casa en Renta en Residencial Privada Jardín, Juárez, N.L.',
                                                         'Casa en Renta en Col. Obrerista en Monterrey, N.L.',
                                                         'Casa en Venta en Nuevo Amanecer en Apodaca, N.L.')
    end
  end
end