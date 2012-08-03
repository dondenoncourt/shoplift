namespace :build_brands_from_text do
  desc 'Create initial brands from text file'
  task :build => :environment do
    puts "Building initial set of brands..."
    # note this will probably be a 1-time thing and the file is on don's machine.
    file = File.new("/work/customers/shoplift/brands.txt", "r")
    while (line = file.gets)
        puts "#{line.gsub(/\s*$/, '')}"
        Brand.find_or_create_by_name(line.gsub(/\s*$/, ''))
    end
    file.close

  end
end
