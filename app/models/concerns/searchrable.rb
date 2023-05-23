module Searchrable
  extend ActiveSupport::Concern
  
  module ClassMethods

      def search(value = "", options = {})
          default_options = {includes: "", queries: [], filters: {}, distinct: true}
          options = default_options.merge(options)
          if value.present?
              string_query = ""
              string_query = build_query(string_query, value, options[:includes], self.table_name, self.columns_hash.to_a)
              if options[:queries].present?
                  options[:queries].each do |query|
                  string_query = build_query(string_query, value, options[:includes], query[:table_name], query[:columns])
                  end
              end
              if options[:filters].present?
                  string_query = build_filter(string_query, options[:filters]) if options[:filters].present?
              end
              return eval "self#{options[:includes]}#{string_query.blank? ? '.all' : string_query}#{options[:distinct] == true ? '.distinct' : ''}"
          else
              return self.all
          end
      end

    private
      def build_query(string_query, value, includes, table_name, kolumns)
        kolumns.each do |_column, _type|
          unless _column.include? '_id' && 'id'
            if string_query.blank?
              case _type.type
              when :uuid
                # TODO: uuid
              when :string
                if _type.default == "{}"
                  # TODO: array de string
                else
                  string_query << ".where(\"LOWER(UNACCENT(#{table_name}.#{_column})) ILIKE LOWER(UNACCENT(\'%#{value}%\'))\")"
                end
              when :integer
                string_query << ".where(\"#{table_name}.#{_column} = #{value} \")" if is_integer?(value)
              when :decimal
                string_query << ".where(\"#{table_name}.#{_column} = #{value} \")" if is_decimal?(value)
              when :boolean
                string_query << ".where(\"#{table_name}.#{_column} = #{to_boolean(value)} \")" if is_boolean?(value)
              when :datetime, :date
                string_query << ".where(\"DATE(#{table_name}.#{_column}) = TO_DATE('#{value.to_date}', 'DD/MM/YYYY') \")" if is_datetime?(value)
              when :inet
                # TODO: ip
              when :jsonb, :json
                # TODO: json
              else
                string_query << ".where(\"#{table_name}.#{_column} = '#{value}'\")"
              end
            else
              case _type.type
              when :uuid
                # TODO: uuid
              when :string
                if _type.default == "{}"
                  # TODO: array de string
                else
                  string_query << ".or(self#{includes}.where(\"LOWER(UNACCENT(#{table_name}.#{_column})) ILIKE LOWER(UNACCENT(\'%#{value}%\'))\"))"
                end
              when :integer
                string_query << ".or(self#{includes}.where(\"#{table_name}.#{_column} = #{value} \"))" if is_integer?(value)
              when :decimal
                string_query << ".or(self#{includes}.where(\"#{table_name}.#{_column} = #{value} \"))" if is_decimal?(value)
              when :boolean
                string_query << ".or(self#{includes}.where(\"#{table_name}.#{_column} = #{to_boolean(value)} \"))" if is_boolean?(value)
              when :datetime, :date
                string_query << ".or(self#{includes}.where(\"DATE(#{table_name}.#{_column}) = TO_DATE('#{value.to_date}', 'DD/MM/YYYY') \"))" if is_datetime?(value)
              when :inet
                # TODO: ip
              when :jsonb, :json
                # TODO: json
              else
                string_query << ".or(self#{includes}.where(\"#{table_name}.#{_column} = '#{value}'\"))"
              end
            end
          end
        end
        string_query
      end

      def build_filter(string_query, filter)
        unless filter.blank?
          filter.each do |key, value|
            _type = ''
            if key.split(".").count == 1
              _type = self.columns_hash[key]
            else
              begin
                _type = key.split(".")[0].singularize.classify.constantize.columns_hash[key.split(".")[1]]
              rescue
              end
            end
            if _type.present?
              unless value.blank?
                case _type.type
                when :uuid
                  if value == 'null'
                    string_query << ".where(\"#{key} is null\")"
                  elsif value.include?(',')
                    string_query << ".where(\"#{key} IN ('#{value.gsub(',','\',\'')}')\")"
                  else
                    string_query << ".where(\"#{key} = '#{value}'\")"
                  end
                when :string
                  if _type.default == "{}"
                    string_query << ".where(\"\'#{value}\' = ANY(#{key})\")"
                  else
                    if value.class == Array
                      query << ".where(\"#{key} IN (?)\",#{value})"
                    else
                      string_query << ".where(\"#{key} = '#{value}'\")"
                    end
                  end
                when :integer
                  string_query << ".where(\"#{key} = #{value} \")" if is_integer?(value)
                when :decimal
                  string_query << ".where(\"#{key} = #{value} \")" if is_decimal?(value)
                when :boolean
                  string_query << ".where(\"#{key} = #{to_boolean(value)} \")" if is_boolean?(value)
                when :datetime, :date
                  if is_array?(value)
                    dates = value.tr('[]', '').split(',')
                    string_query << ".where(\"#{key} BETWEEN '#{dates[0].to_datetime.strftime("%Y-%m-%d %H:%M:%S")}' AND '#{dates[1].to_datetime.strftime("%Y-%m-%d %H:%M:%S")}'\")"
                  else
                    string_query << ".where(\"DATE(#{key}) = TO_DATE('#{value.to_date}', 'DD/MM/YYYY') \")" if is_datetime?(value)
                  end
                when :inet
                  # TODO: ip
                when :jsonb, :json
                  # TODO: json
                else
                  if value == 'null'
                    string_query << ".where(\"#{key} is null\")"
                  else
                    string_query << ".where(\"#{key} = '#{value}'\")"
                  end
                end
              end
            else
              unless value.blank?
                if is_array?(value)
                  dates = value.tr('[]', '').split(',')
                  if is_datetime?(dates[0])
                    string_query << ".where(\"#{key} BETWEEN '#{dates[0].to_datetime.strftime("%Y-%m-%d %H:%M:%S")}' AND '#{dates[1].to_datetime.strftime("%Y-%m-%d %H:%M:%S")}'\")"
                  else
                    string_query << ".where(\"#{key} BETWEEN #{dates[0]} AND #{dates[1]} \")"
                  end
                elsif is_integer?(value)
                  string_query << ".where(\"#{key} = #{value} \")" if is_integer?(value)
                elsif is_decimal?(value)
                  string_query << ".where(\"#{key} = #{value} \")"
                elsif is_boolean?(value)
                  string_query << ".where(\"#{key} = #{to_boolean(value)} \")"
                elsif is_uuid?(value)
                  string_query << ".where(\"#{key} = '#{value}' \")"
                elsif is_datetime?(value)
                  string_query << ".where(\"DATE(#{key}) = TO_DATE('#{value.to_date}', 'DD/MM/YYYY') \")"
                else
                  if value == 'null'
                    string_query << ".where(\"#{key} is null\")"
                  else
                    string_query << ".where(\"#{key} = '#{value}'\")"
                  end
                end
              end
            end
          end
        end
        string_query
      end

      def is_integer?(s)
        /\A[-+]?\d+\z/ === s
      end

      def is_decimal?(s)
        /\A-?(?:\d+(?:\.\d*)?|\.\d+)\z/ === s
      end

      def is_boolean?(s)
        begin
          to_boolean(s)
          return true
        rescue
          return false
        end
      end

      def to_boolean(s)
        case s.downcase
        when "true","sim","1"
          return true
        when "false","nÃ£o","nao","0"
          return false
        else
          raise "CannotCastBoolean"
        end
      end

      def is_datetime?(s)
        return false if s.match(/[A-Za-z]/)
        begin
          if /(\d{1,2}[-\/]\d{1,2}[-\/]\d{4})|(\d{4}[-\/]\d{1,2}[-\/]\d{1,2})/.match(s)
            s.to_date
            return true
          else
            return false
          end
        rescue
          return false
        end
      end
  end
end