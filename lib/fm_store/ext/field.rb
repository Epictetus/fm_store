module Rfm
  module Metadata
    class Field
      def coerce(value, resultset)
        return nil if (value.nil? || value.empty?)
        case self.result
        when "text"      then value
        when "number"    then BigDecimal.new(value)
        when "date"      then Date.strptime(value, resultset.date_format)
        when "time"      then DateTime.strptime("1/1/-4712 #{value}", "%m/%d/%Y #{resultset.time_format}")
        when "timestamp" then DateTime.strptime(value, resultset.timestamp_format)
        when "container" then URI.parse("#{resultset.server.scheme}://#{resultset.server.host_name}:#{resultset.server.port}#{value}")
        else nil
        end
      rescue
        nil
      end
    end
  end
end