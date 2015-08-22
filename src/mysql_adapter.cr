require "./mysql_adapter/version"
require "active_record"
require "active_record/sql/query_generator"
require "mysql"

module MysqlAdapter
  class Adapter < ActiveRecord::Adapter
    query_generator ActiveRecord::Sql::QueryGenerator.new

    def self.build(table_name, primary_field, fields, register = true)
      new(table_name, primary_field, fields, register)
    end

    getter connection, table_name, primary_field, fields

    def initialize(@table_name, @primary_field, @fields, register = true)
      @connection = MySQL.connect("127.0.0.1", "crystal_mysql", "", "crystal_mysql_test", 3306_u16, nil)
    end

    def create(fields)
      field_names = fields.keys.map { |name| name }.join(", ")
      field_values = fields.keys.map { |name| ":__value__#{name}" }.join(", ")

      query = "INSERT INTO #{table_name}(#{field_names}) VALUES(#{field_values})"

      params = {} of String => MySQL::Types::SqlType
      fields.each do |name, value|
        unless value.null?
          params["__name__#{name}"] = name
          params["__value__#{name}"] = value.not_null!
        end
      end

      MySQL::Query.new(query, params).run(connection)

      result = connection.query(%{SELECT #{primary_field} FROM #{table_name} ORDER BY #{primary_field} DESC LIMIT 1})
      result.not_nil![0].not_nil![0]
    end

    def find(id)
      query = "SELECT #{fields.join(", ")} FROM #{table_name} WHERE #{primary_field} = :primary_key LIMIT 1"
      result = MySQL::Query.new(query, { "primary_key" => id.not_null! }).run(connection)

      fields = {} of String => ActiveRecord::SupportedType
      self.fields.each_with_index do |name, index|
        next unless result
        value = result[0][index]
        if value.is_a?(ActiveRecord::SupportedType)
          fields[name] = value
        elsif !value.is_a?(Nil)
          puts "Encountered unsupported type: #{value.class}, of type: #{typeof(value)}"
        end
      end

      fields
    end

    def index
      [] of ActiveRecord::Fields
    end

    def where(query_hash)
      index
    end

    def where(query, params)
      index
    end

    def update(id, fields)
    end

    def delete(id)
    end
  end
end
