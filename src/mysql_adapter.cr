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

      result = connection.query(%{SELECT #{primary_field} FROM #{table_name} ORDER BY #{primary_field} DESC LIMIT 1})
      result.not_nil![0].not_nil![0]
    end

    def read(id)
      # FIXME should be an argument from active_record.cr
      primary_field = "id"
      field_names = ["id", "last_name", "first_name", "number_of_dependents"]

      if id.is_a?(Int)
        query = "SELECT #{field_names.join(", ")} FROM #{table_name} WHERE #{primary_field} = :primary_key LIMIT 1"
        result = MySQL::Query.new(query, { "primary_key" => id }).run(connection)

        fields = {} of String => ActiveRecord::SupportedType
        field_names.each_with_index do |name, index|
          next unless result
          value = result[0][index]
          if value.is_a?(ActiveRecord::SupportedType)
            fields[name] = value
          else
            puts "Encountered unsupported type: #{typeof(value)}"
          end
        end

        fields
      else
        fail "Id is null"
      end
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
