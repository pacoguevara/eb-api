require 'fakeweb'
require_relative '../service_wrapper'

describe EasyBroker::ServiceWrapper do
  let(:eb_response) do
    '{
      "pagination": {
        "limit": 5,
        "page": 1,
        "total": 1104,
        "next_page": "https://api.stagingeb.com/v1/properties?limit=5&page=2"
      },
      "content": [
        {
          "public_id": "EB-B0425",
          "title": "Casa bien bonita",
          "private_description": "Cuidado con el perro! Toca el timbre antes de pasar.",
          "title_image_full": "https://assets.stagingeb.com/property_images/20425/47919/EB-B0425.jpg?version=1555346000",
          "title_image_thumb": "https://assets.stagingeb.com/property_images/20425/47919/EB-B0425.jpg?version=1555346000&width=200",
          "location": "San Antonio El Grande, Aquiles Serdán, Chihuahua",
          "operations": [
            {
              "type": "sale",
              "amount": 8000,
              "currency": "MXN",
              "formatted_amount": "$8,000",
              "commission": {
                "type": "percentage",
                "value": "5.0"
              },
              "unit": "square_meter"
            }
          ],
          "bedrooms": 4,
          "bathrooms": 4,
          "parking_spaces": 3,
          "property_type": "Casa",
          "lot_size": 300,
          "construction_size": 220,
          "updated_at": "2024-08-12T23:33:24-06:00",
          "agent": "Alejandro Blanco Zivec",
          "show_prices": true,
          "share_commission": true
        },
        {
          "public_id": "EB-B1027",
          "title": "Bodega en Naucalpan",
          "private_description": null,
          "title_image_full": "https://assets.stagingeb.com/property_images/21027/29467/EB-B1027.jpg?version=1544817901",
          "title_image_thumb": "https://assets.stagingeb.com/property_images/21027/29467/EB-B1027.jpg?version=1544817901&width=200",
          "location": "2a Ampliación Presidentes, Álvaro Obregón, Ciudad de México",
          "operations": [
            {
              "type": "sale",
              "amount": 12500000,
              "currency": "MXN",
              "formatted_amount": "$12,500,000",
              "commission": {
                "type": "percentage",
                "value": "5.0"
              },
              "unit": "total"
            }
          ],
          "bedrooms": null,
          "bathrooms": null,
          "parking_spaces": null,
          "property_type": "Bodega comercial",
          "lot_size": 5394,
          "construction_size": 1240,
          "updated_at": "2024-08-12T23:33:40-06:00",
          "agent": "Alejandro Blanco Zivec",
          "show_prices": true,
          "share_commission": true
        },
        {
          "public_id": "EB-B4994",
          "title": "Casa en Renta en Residencial Privada Jardín, Juárez, N.L.",
          "private_description": null,
          "title_image_full": "https://assets.stagingeb.com/property_images/24994/49091/EB-B4994.jpg?version=1555541680",
          "title_image_thumb": "https://assets.stagingeb.com/property_images/24994/49091/EB-B4994.jpg?version=1555541680&width=200",
          "location": "Privadas Jardines Residencial, Juárez, Nuevo León",
          "operations": [
            {
              "type": "rental",
              "amount": 3500,
              "currency": "MXN",
              "formatted_amount": "$3,500",
              "commission": {
                "type": "percentage"
              },
              "unit": "total"
            }
          ],
          "bedrooms": 2,
          "bathrooms": 1,
          "parking_spaces": null,
          "property_type": "Casa",
          "lot_size": 90,
          "construction_size": 65,
          "updated_at": "2024-08-12T23:34:12-06:00",
          "agent": "Alejandro Blanco Zivec",
          "show_prices": true,
          "share_commission": false
        },
        {
          "public_id": "EB-B4995",
          "title": "Casa en Renta en Col. Obrerista en Monterrey, N.L.",
          "private_description": null,
          "title_image_full": "https://assets.stagingeb.com/property_images/24995/49092/EB-B4995.jpg?version=1555541681",
          "title_image_thumb": "https://assets.stagingeb.com/property_images/24995/49092/EB-B4995.jpg?version=1555541681&width=200",
          "location": "Obrerista, Monterrey, Nuevo León",
          "operations": [
            {
              "type": "rental",
              "amount": 10000,
              "currency": "MXN",
              "formatted_amount": "$10,000",
              "commission": {
                "type": "percentage"
              },
              "unit": "total"
            }
          ],
          "bedrooms": 6,
          "bathrooms": 2,
          "parking_spaces": null,
          "property_type": "Casa",
          "lot_size": 180,
          "construction_size": 250,
          "updated_at": "2024-08-12T23:34:12-06:00",
          "agent": "Alejandro Blanco Zivec",
          "show_prices": true,
          "share_commission": false
        },
        {
          "public_id": "EB-B4996",
          "title": "Casa en Venta en Nuevo Amanecer en Apodaca, N.L.",
          "private_description": null,
          "title_image_full": "https://assets.stagingeb.com/property_images/24996/49093/EB-B4996.jpg?version=1555541683",
          "title_image_thumb": "https://assets.stagingeb.com/property_images/24996/49093/EB-B4996.jpg?version=1555541683&width=200",
          "location": "Nuevo Amanecer 1, Apodaca, Nuevo León",
          "operations": [
            {
              "type": "sale",
              "amount": 650000,
              "currency": "MXN",
              "formatted_amount": "$650,000",
              "commission": {
                "type": "percentage"
              },
              "unit": "total"
            }
          ],
          "bedrooms": 4,
          "bathrooms": 2,
          "parking_spaces": null,
          "property_type": "Casa",
          "lot_size": 105,
          "construction_size": 96,
          "updated_at": "2024-08-12T23:34:12-06:00",
          "agent": "Alejandro Blanco Zivec",
          "show_prices": true,
          "share_commission": false
        }
      ]
    }'
  end

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