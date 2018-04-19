# ImageLimitResize

It is a library for shrinking the image to equal ratio. It depends on rmagick.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'image_limit_resize'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install image_limit_resize

## Usage

```
require 'image_limit_resize'

file = './sakura.jpg'
image_limit = ImageLimitResize::Base.new(file: file)
image_limit.format #=> 'JPEG'
image_limit.size = 90
image_limit.resize('sakura_resize.jpg')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kanayannet/image_limit_resize. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ImageLimitResize project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kanayannet/image_limit_resize/blob/master/CODE_OF_CONDUCT.md).
