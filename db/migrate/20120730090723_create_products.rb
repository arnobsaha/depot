class CreateProducts < ActiveRecord::Migration
  # Activerecord for changing DB
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price

      t.timestamps
    end
  end
  # Activerecord for db migrate create
  def self.up
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price, :precision => 8, :scale => 2
      t.timestamps
    end
  end
  # Activerecord for db migrate down
  def self.down
    drop_table :products
  end

end
