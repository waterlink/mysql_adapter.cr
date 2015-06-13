require "./mysql_adapter/version"
require "active_record"

module MysqlAdapter
  class Adapter < ActiveRecord::Adapter
    def self.build(table_name, register = true)
      new(table_name, register)
    end

    getter adapter
    def initialize(table_name, register = true)
      @adapter = ActiveRecord::NullAdapter.build(table_name, register)
    end

    def create(fields, primary_field)
      adapter.create(fields, primary_field)
    end

    def read(id)
      adapter.read(id)
    end

    def index
      adapter.index
    end

    def where(query_hash)
      adapter.where(query_hash)
    end

    def where(query, params)
      adapter.where(query, params)
    end

    def update(id, fields)
      adapter.update(id, fields)
    end

    def delete(id)
      adapter.delete(id)
    end
  end
end
