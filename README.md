# aquel-sequel [![Build Status](https://travis-ci.org/youpy/aquel-sequel.svg)](https://travis-ci.org/youpy/aquel-sequel)

A Sequel adapter for aquel

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aquel-sequel'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aquel-sequel

## Usage

```ruby
require 'aquel/sequel'

aquel = Aquel.define 'tsv' do
  has_header

  document do |attributes|
    open(attributes['path'])
  end

  item do |document|
    document.gets
  end

  split do |item|
    item.chomp.split(/\t/)
  end
end

DB = Sequel.connect('aquel:///', :database => aquel)
```

```ruby
items = DB.select(:col1, :col3).from('tsv').where(path: tsv_path).exclude(col1: 'foo1').all
```

## Contributing

1. Fork it ( https://github.com/youpy/aquel-sequel/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
