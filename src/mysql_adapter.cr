require "./mysql_adapter/version"
require "active_record"
require "active_record/sql/query_generator"
require "mysql"

module MysqlAdapter
  class Adapter < ActiveRecord::Adapter
    query_generator ActiveRecord::Sql::QueryGenerator.new

    def self.build(table_name, register = true)
      new(table_name, register)
    end

    getter connection
    getter table_name

    def initialize(@table_name, register = true)
      @connection = MySQL.connect("127.0.0.1", "crystal_mysql", "", "crystal_mysql_test", 3306_u16, nil)
    end

    def create(fields, primary_field)
      field_names = fields.keys.map { |name| name }.join(", ")
      field_values = fields.keys.map { |name| ":__value__#{name}" }.join(", ")

      query = "INSERT INTO #{table_name}(#{field_names}) VALUES(#{field_values})"

      params = {} of String => MySQL::Types::SqlType
      fields.each do |name, value|
        params["__name__#{name}"] = name
        params["__value__#{name}"] = value
      end

      MySQL::Query.new(query, params).run(connection)

      conn.query(%{SELECT #{primary_field} FROM #{table_name} ORDER #{primary_field} DESC LIMIT 1})[0][0]
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
