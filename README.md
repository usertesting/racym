# racym

[![Travis](https://img.shields.io/travis/usertesting/racym?style=for-the-badge)](https://travis-ci.org/usertesting/racym) [![Coveralls github](https://img.shields.io/coveralls/github/usertesting/racym?style=for-the-badge)](https://coveralls.io/github/usertesting/racym) [![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/usertesting/racym?style=for-the-badge)](https://codeclimate.com/github/usertesting/racym)

Rails Application Configuration for Yield Main (RACYM)

racym is used as a shortcut to rails configuration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "racym"
```

And then execute:

```ruby
$ bundle install
```

## Usage

### Setting config values

In your `config/application.rb` add config settings:

```ruby
module MyApp
  class Application < Rails::Application

  ...

  # Add a custom config setting here:
  config.foo = "bar"

  # Or a proc:
  config.biz = -> { DateTime.current }
```

### Getting config values

From anywhere in your Rails application (controllers/helpers/views - should be available anywhere!)

```ruby
puts racym(:foo)
# => "bar"

puts racym(:biz)
# => Wed, 02 Oct 2019 11:13:20 -0700

# ten minutes later:
puts racym(:biz)
# => Wed, 02 Oct 2019 11:23:20 -0700
```

### Multilevel key/values

#### Setting:

```ruby
module MyApp
  class Application < Rails::Application

  ...

  config.foo.username = "BAR"
  config.foo.password = "BIZ"
```

#### Getting:

```ruby
puts racym(:foo, :username)
# => "BAR"

puts racym(:foo, :password)
# => "BIZ"
```

## License

[MIT](LICENSE).

Library created by [UserTesting](https://usertesting.com)

![UserTesting](doc/UserTesting.png)

## Contributing

1. Fork it ( https://github.com/usertesting/racym/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
