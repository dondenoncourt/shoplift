namespace :category do
  desc 'Create initial categories'
  task :create => :environment do
    puts "Creating categories..."
    categories = ['Runway Fashion', 'Wear-to-work', 'School Clothes', 'The Life of Leisure', 'Beauty Products', 'The Modern Home', 'Worthwhile Technology', 'Foodie Supplies']
    categories.each do |category|
      Category.where(:name => category, :param => category.gsub('-', '_').gsub(' ', '_').downcase).first_or_create
    end
    puts "Categories found or created."
  end
end