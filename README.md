# mysql_adapter.cr [![Build Status](https://travis-ci.org/waterlink/mysql_adapter.cr.svg?branch=master)](https://travis-ci.org/waterlink/mysql_adapter.cr)

Mysql adapter for [active_record.cr](https://github.com/waterlink/active_record.cr). Uses [crystal-mysql library](https://github.com/waterlink/crystal-mysql)

## TODO

- [x] Implement with some default connection config
- [x] Fix segfaults from upstrem lib (`crystal-mysql`)
- [ ] Figure out a way to provide connection pool

## Installation

Add it to your `shard.yml`

```yml
dependencies:
  mysql_adapter:
    github: waterlink/mysql_adapter.cr
    version: 0.0.2
```

## Usage

```crystal
require "active_record"
require "mysql_adapter"

class Person < ActiveRecord::Model
  adapter mysql
  # ...
end
```

## Development

After cloning run `crystal deps` or `crystal deps update`.

Just use normal TDD cycle. To run tests use:

```
./bin/test
```

This will run unit test in `spec/` and integration spec in `integration/`.

## Contributing

1. Fork it ( https://github.com/waterlink/mysql_adapter.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
