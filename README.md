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
    version: ~> 0.2
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

### Connection configuration

Currently, connection can be configured through environment variables:

```bash
$ export MYSQL_HOST=localhost
$ export MYSQL_PORT=3306
$ export MYSQL_USER=test
$ export MYSQL_PASSWORD=welcome
$ export MYSQL_DATABASE=test_db

# And run your code
$ crystal run src/your_code.cr
```

Alternative way of doing that is to set these variables programmatically before
using `mysql_adapter` or `active_record`:

```crystal
# You are free to read these values from config file for instance.
ENV["MYSQL_HOST"] = "localhost"
ENV["MYSQL_PORT"] = 3306
ENV["MYSQL_USER"] = "test"
ENV["MYSQL_PASSWORD"] = "welcome"
ENV["MYSQL_DATABASE"] = "test_db"
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
