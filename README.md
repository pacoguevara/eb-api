# eb-api
## Description

This project wraps the EasyBroker API into a ruby consumable API

## Usage
Right now this API only query the properties resource and it exposes only 2 _methods_

### get
- Retrieves a collection of properties
- Accepts an optional _param_ page to indicate what page to fetch
```ruby
# returns an EasyBroker::Properties object
result = EasyBroker::Properties.get
result.content # Show all the properties
result.page # Current page
result.total # Properties total
result.list_titles # List the titles only ['Title 1', 'Title 2', ...]
```

### get_titles
- List the titles only
- Accepts an optional _param_ page to indicate what page to fetch
```ruby
# returns an array with the properties titles
EasyBroker::Properties.get_titles => ['Title 1', 'Title 2', ...]
```

## Testing
In order to run the test you need to install 2 gems
```ruby
gem install rspec
gem install fakeweb
```
Then to run it
```ruby
rspec spec/service_wrapper_spec.rb
rspec spec/properties_spec.rb
```
