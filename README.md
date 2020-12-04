# Solrbee

![Bee photo (c) David Chandek-Stark](https://raw.githubusercontent.com/dchandekstark/images/main/solrbee.jpg)

Solrbee is intended as a lightweight library for interacting with a modern Solr instance
as NoSQL data store.

We are currently building on the JSON APIs (V1).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'solrbee'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install solrbee

## Usage

```
$ bundle console
irb(main):001:0> client = Solrbee::Client.new('solrbee')
=> #<Solrbee::Client:0x00007fd3410d7c50 @collection="solrbee", @uri=#<URI::HTTP http://localhost:8983/solr/solrbee>>
irb(main):002:0> client.unique_key
=> "id"
irb(main):003:0> client.schema_version
=> 1.6
irb(main):004:0> client.schema_name
=> "default-config"
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/solrbee.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
