# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Emanuel', :city => cities.first)
=begin
*** Be warned: this seeds.rb script removes existing data from the products table before loading in
the new data. You might not want to run it if you’ve just spent several hours
typing your own data into your application!

To populate your products table with test data, simply run the following com-
mand:
      depot> rake db:seed

=end
Product.delete_all
# . . .
Product.create(:title => 'Programming Ruby 1.9',
               :description =>
                   %{<p>
Ruby is the fastest growing and most exciting dynamic language
out there. If you need to get working programs delivered fast,
you should add Ruby to your toolbox.
</p>},
               :image_url => '/images/ruby.jpg',
               :price => 49.50)
# . . .
Product.create(:title => 'Programming Php',
               :description =>
                   %{<p>
It is a php language
</p>},
               :image_url => '/images/ruby.jpg',
               :price => 40.90)
