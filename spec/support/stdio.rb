#      _      _ _         _          _
#  ___| |_ __| (_) ___   | |__   ___| |_ __   ___ _ __ ___
# / __| __/ _` | |/ _ \  | '_ \ / _ \ | '_ \ / _ \ '__/ __|
# \__ \ || (_| | | (_) | | | | |  __/ | |_) |  __/ |  \__ \
# |___/\__\__,_|_|\___/  |_| |_|\___|_| .__/ \___|_|  |___/
#                                     |_|   by stephan.com

# especially handy for testing interactive rake tasks
# best in an rspec around block, and can even be chained eg:
#
# around do |example|
#   suppress_stdout do
#     fake_stdin('y', &example)
#   end
# end
module StdioHelpers
  # Replace $stdin with a fake one using StringIO
  #
  # @see https://gist.github.com/nu7hatch/631329
  # @param args [Array<String>] string(s) to use as input
  # @yield []
  def fake_stdin(*args)
    $stdin = StringIO.new
    $stdin.puts(args.shift) until args.empty?
    $stdin.rewind
    yield
  ensure
    $stdin = STDIN
  end

  # redirect output to the bit bucket
  #
  # @see http://www.hacker-dictionary.com/terms/bit-bucket
  # @see https://stackoverflow.com/a/15432948/444955
  # @yield []
  def suppress_stdout
    original_stderr = $stderr
    original_stdout = $stdout
    $stderr = File.open(File::NULL, 'w')
    $stdout = File.open(File::NULL, 'w')
    yield
  ensure
    $stderr = original_stderr
    $stdout = original_stdout
  end
end

RSpec.configure do |config|
  config.include StdioHelpers
end
