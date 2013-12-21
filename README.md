# OV Chipkaart

An OV Chipkaart gem, which scrapes the OV Chipkaart website and provides an easy to use API.

The OV Chipkaart is the Dutch national transportation card for public transport. The use and transactions are regulated by the TLS.


## Installation

The OV Chipkaart gem makes use of the [chromedriver](https://code.google.com/p/chromedriver/) in combination with [capybara](https://github.com/jnicklas/capybara) and [selenium](https://github.com/SeleniumHQ/selenium) under the hood.

For users with homebrew:

    $ brew install chromedriver


Add the gem to your Gemfile:

```ruby
gem 'ovchipkaart'
```

You might need to update the chromedriver after you ran `bundle install`:

    $ chromedriver-update
    
*Chromedriver update with thanks to [flavorjones/chromedriver-helper](https://github.com/flavorjones/chromedriver-helper) and [mars/chromedriver-helper](https://github.com/flavorjones/chromedriver-helper/pull/9).*

## Configuration

You need to provide your credentials from the OV Chipkaart website. You can use a hash or a YAML file:

```ruby
Ovchipkaart.configure({ username: 'foo', password: 'bar'})
    
Ovchipkaart.configure_with(path_to_yaml_file)
Ovchipkaart.configure_with('config/credentials.yml')
```

*Don't forget to put this in your .gitignore*

## Usage

Because the TLS doesn't provide an API for the OV Chipkaart, it scrapes the website and downloads the transactions to the filesystem for parsing. Therefore some methods might feel slow.

**Balance and timestamp**

```ruby
ov_chipkaart = Ovchipkaart::Api.new
ov_chipkaart.balance         #=> € 45,30
ov_chipkaart.last_updated    #=> (12-10-2013 20:57)
```

**Journeys and transactions**

Every journey or transaction is a hash with ten keys: `datum`, `checkin`, `vertrek`, `checkuit`, `bestemming`, `bedrag`, `transactie`, `klasse`, `product` and `opmerkingen`.

Based on the `transactie` key everything is sorted in six categories:

```ruby
ov_chipkaart = Ovchipkaart::Api.new
```

1. `ov_chipkaart.journeys` contains all the finish journeys.
2. `ov_chipkaart.checkins` contains all the checkins, when the journey starts.
3. `ov_chipkaart.forgotten_checkouts` contains all the journeys that started, but didn't end, because there was no `checkuit`. These can be used to claim your money back.
4. `ov_chipkaart.additions` contains all the additions to the balance of the OV Chipkaart.
5. `ov_chipkaart.products` contains all the additions of products to the OV Chipkaart, such as subscriptions and discounts.
6. `ov_chipkaart.unclassified` contains everything that couldn't be specified.

## Troubleshooting

**Credentials**

The OV Chipkaart gem needs your credentials to login on the OV Chipkaart website.

If you have trouble configuring your credentials check the YAML for syntax errors and make sure that you only specify an `username` and `password`. Otherwise it will raise an error.

**Chromedriver**

Make sure you have installed the latest `chromedriver`. You can use homebrew to easily install the `chromedriver`. You might try running the `chromedriver-update` command, which downloads the helper for the `chromedriver` that is used by `selenium` with `capybara`.

The OV Chipkaart gem current uses `chromedriver` version `2.8.241036`.

**OV Chipkaart results**

Since this gem relies on scraping the OV Chipkaart website, it might break during an update of the website. If you experience this issue either help out with a Pull request or send me a message.

## Contributing

Pull requests are welcome:

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
