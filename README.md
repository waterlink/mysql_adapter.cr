# mysql_adapter.cr

Mysql adapter for [active_record.cr](https://github.com/waterlink/active_record.cr). Uses [crystal-mysql library](https://github.com/waterlink/crystal-mysql)

## TODO

- [ ] Implement with some default connection config
- [ ] Figure out a way to provide connection pool

## Installation

Add it to `Projectfile`

```crystal
deps do
  github "waterlink/active_record.cr"
  github "waterlink/crystal-mysql"
  github "waterlink/mysql_adapter.cr"
end
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
