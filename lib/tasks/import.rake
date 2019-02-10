namespace :import do
  desc 'Read a CSV file of user records'
  task :users, [:filename] => %i[destructive environment] do |_t, args|
    raise Nope unless args.filename

    fullpath = Rails.root.join(args.filename)
    Import.new(User).import(fullpath)
  end

  desc 'Read a CSV file of order records'
  task :orders, [:filename] => %i[destructive environment] do |_t, args|
    raise Nope unless args.filename

    fullpath = Rails.root.join(args.filename)
    Import.new(Order).import(fullpath)
  end
end
