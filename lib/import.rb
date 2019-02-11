require 'ruby-progressbar'
require 'smarter_csv'

# Some handy (semi)-reusable methods for importing CSV files to ActiveRecord
# intended for use from a rake task.
class Import
  # Initialize importer
  #
  # @param klass [Class] ActiveRecord class to instantiate records
  # @param mapping [Hash] key/values to remap keys
  def initialize(klass, mapping = { id: :old_id })
    @klass = klass
    @mapping = mapping
  end

  # Convert time from quiply-exclusive format to standard string
  # Also adds '-0800' to attempt to deal with timezones
  #
  # @param str [String] input datetime in nonstandard format: mm/dd/yyyy hh:mm:ss
  # @return [String] normalized time string in format: yyyy-mm-dd hh:mm:ss -0800
  MMDDYY_HHMMSS_REGEXP = %r{(?<month>\d\d)\/(?<day>\d\d)\/(?<year>\d\d\d\d)\s(?<time>\d\d:\d\d:\d\d)}.freeze
  def self.normalize_time(str)
    parts = str.match(MMDDYY_HHMMSS_REGEXP)
    "#{parts[:year]}-#{parts[:month]}-#{parts[:day]} #{parts[:time]} -0800"
  end

  # normalize both standard timestamps in an attributes hash
  #
  # @param attrs [Hash] attributes hash potentially including :created_at and :updated_at
  # @return [Hash] hash with timestamps normalized
  def self.normalize_stamps(attrs)
    attrs[:created_at] = normalize_time(attrs[:created_at]) if attrs.key?(:created_at)
    attrs[:updated_at] = normalize_time(attrs[:updated_at]) if attrs.key?(:updated_at)
    attrs
  end

  # import a given CSV filename
  # includes progressbar output - which should perhaps be removed and put in the rake task
  #
  # param filename [String] path to a CSV file to import
  def import(filename)
    csv = SmarterCSV.process(filename, key_mapping: @mapping)
    progressbar = ProgressBar.create(total: csv.size, title: filename, format: '%t %c of %C |%B|')
    csv.each do |attrs|
      progressbar.increment
      attrs = Import.normalize_stamps(attrs)
      record = @klass.new(attrs)
      next unless record.valid? # skip invalid records

      record.save!
    end
    progressbar.finish
  end
end
