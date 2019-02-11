#      _           _                   _   _
#   __| | ___  ___| |_ _ __ _   _  ___| |_(_)_   _____
#  / _` |/ _ \/ __| __| '__| | | |/ __| __| \ \ / / _ \
# | (_| |  __/\__ \ |_| |  | |_| | (__| |_| |\ V /  __/
#  \__,_|\___||___/\__|_|   \__,_|\___|\__|_| \_/ \___|

# handy guard for destructive rake tasks
# just include this before any troublesome task
# typical usage:
#   task :riskytask, [:destructive, :environment] do

# found here:
# http://technotes.iangreenleaf.com/posts/confirmation-for-destructive-rake-tasks.html

class Nope < RuntimeError; end

task :destructive do
  puts 'This task is destructive! Are you sure you want to continue? [y/N]'
  input = $stdin.gets.chomp
  raise Nope unless input.casecmp('y').zero?
end
