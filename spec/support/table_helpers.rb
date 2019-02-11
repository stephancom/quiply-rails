# source: https://gist.github.com/hoasung01/96ba3cc095562894b2f282e9ece84594#file-table_helpers-rb
# https://techblog.vn/index.php/how-to-assert-table-html-in-page-with-rspeccapybara
# https://stackoverflow.com/a/43086623/444955
# plus a little of:
# https://gist.github.com/mcmire/5860315
# https://github.com/jnicklas/capybara_table
# https://gist.github.com/codenamev/3105157
#
# my fork:
# https://gist.github.com/stephancom/cf8d5de37dcd7f49c54772e3302f0bfe
module TableHelpers
  module ArrayMethods
    def find_row(expected_row)
      find_index do |row|
        expected_row.all? do |expected_column|
          first_column = row.find_index { |column|
            content = normalize_content(column.content)
            expected_content = normalize_content(expected_column)
            matching_parts = expected_content.split(/\s*\*\s*/, -1).collect { |part| Regexp.escape(part) }
            matching_expression = /\A#{matching_parts.join(".*")}\z/
            content =~ matching_expression
          }
          if first_column.nil?
            false
          else
            row = row[(first_column + 1)..-1]
            true
          end
        end
      end
    end

    # Only cross-Ruby way to get a character for its UTF-16 (hex) representation
    def character(code)
      [code.to_i(16)].pack('U*')
    end

    def normalize_content(content)
      shy = character('00ad') # soft hyphen
      nbsp = character('00a0') # non-breaking space
      zwsp = character('200b') # zero-width space
      content = content.gsub(/[#{shy}#{zwsp}]/, '')
      content = content.gsub(/[\r\n\t#{nbsp}]+/, ' ')
      content = content.gsub(/ {2,}/, ' ')
      content = content.strip
      content
    end

  end

  rspec = defined?(RSpec) ? RSpec : Spec

  rspec::Matchers.define :contain_table do |*args|
    match do |tables|
      @last_unmatched_row = nil
      @extra_rows = nil
      @best_rows_matched = -1
      options = args.extract_options!
      expected_table = args.first
      tables.any? do |table|
        skipped_rows = []
        rows_matched = 0
        match = expected_table.all? { |expected_row|
          if @best_rows_matched < rows_matched
            @last_unmatched_row = expected_row
            @best_rows_matched = rows_matched
          end
          table.extend ArrayMethods
          first_row = table.find_row(expected_row)
          if first_row.nil?
            false
          else
            rows_matched += 1
            if options[:unordered]
              table.delete_at(first_row)
            else
              skipped_rows += table[0...first_row]
              table = table[(first_row + 1)..-1]
            end
            true
          end
        }
        remaining_rows = skipped_rows + table
        if match && options[:exactly] && !remaining_rows.empty?
          @extra_rows = remaining_rows
          match = false
        end
        match
      end
    end

    failure_message do
      if @extra_rows
        "Found the following extra row: #{@extra_rows.first.collect(&:content).collect(&:squish).inspect}"
      elsif @last_unmatched_row
        "Could not find the following row: #{@last_unmatched_row.inspect}"
      else
        'Could not find a table'
      end
    end

    failure_message_when_negated do
      "Found the complete table: #{args.first.inspect}."
    end
  end

  def parse_table(table)
    if table.is_a?(String)
      # multiline string. split it assuming a format like cucumber tables have.
      table.split(/\n/).collect do |line|
        line.sub!(/^\|/, '')
        line.sub!(/\|$/, '')
        line.split(/\s*\|\s*/).map(&:strip)
      end
    else
      table.raw
    end
  end

  def expect_table(cuketable, options = {})
    rows = parse_table(cuketable)
    document = Nokogiri::HTML(page.body)
    xtable = document.xpath('//table').collect { |table| table.xpath('.//tr').collect { |row| row.xpath('.//th|td') } }
    in_order = options.delete(:ordered)

    xtable.should contain_table(rows, in_order)
  end
end

RSpec.configure do |config|
  config.include TableHelpers
end
