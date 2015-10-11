require "spec"
require "../src/mysql_adapter"
require "active_record/null_adapter"

ActiveRecord::Registry.register_adapter("null", MysqlAdapter::Adapter)

Spec.before_each do
  MysqlAdapter::Adapter._reset_do_this_only_in_specs_78367c96affaacd7
end

Spec.after_each do
  MysqlAdapter::Adapter._reset_do_this_only_in_specs_78367c96affaacd7
end

require "../modules/active_record/spec/fake_adapter"
require "../modules/active_record/spec/active_record_spec"
