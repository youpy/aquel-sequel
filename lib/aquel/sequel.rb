require 'sequel'
require 'aquel'

module Sequel
  module Aquel
    class Database < Sequel::Database
      set_adapter_scheme :aquel

      def connect(server)
        opts = server_opts(server)
        opts[:database]
      end

      def disconnect_connection(c)
      end

      def execute(sql, opts=OPTS)
        synchronize(opts[:server]) do |conn|
          r = log_yield(sql){conn.execute(sql)}
          yield(r) if block_given?
          r
        end
      end

      def identifier_input_method_default; nil; end
      def identifier_output_method_default; nil; end
    end

    class Dataset < Sequel::Dataset
      def_sql_method(self, :select, %w'select columns from where')

      Database::DatasetClass = self

      def fetch_rows(sql)
        execute(sql) do |result|
          result.each do |row|
            yield row
          end
        end
        self
      end
    end
  end
end
