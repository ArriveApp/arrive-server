seed_file = "#{Rails.root}/db/seeds/#{Rails.env}.rb"
if File.exists?(seed_file)
  puts "Loading #{Rails.env} seed data..."
  require seed_file
end
