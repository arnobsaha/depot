=begin
  Rails can tell from the name of the migration that you are adding one or more
  columns to the line_items table and can pick up the names and data types for
  each column from the last argument. The two patterns that Rails matches
  on is add_XXX_to_TABLE and remove_XXX_from_TABLE where the value of XXX is
  ignored; what matters is the list of column names and types that appear after
  the migration name.
=end

class AddQuantityToLineItems < ActiveRecord::Migration
  #def change
  #  add_column :line_items, :quantity, :integer
  #end
  def self.up
    add_column :line_items, :quantity, :integer, :default => 1
  end
  def self.down
    remove_column :line_items, :quantity
  end
end
