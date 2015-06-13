require "spec"
require "../src/mysql_adapter"
require "active_record/null_adapter"

ActiveRecord::Registry.register_adapter("null", MysqlAdapter::Adapter)

require "../.deps/waterlink-active_record.cr/spec/fake_adapter"
require "../.deps/waterlink-active_record.cr/spec/active_record_spec"
