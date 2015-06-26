class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :name
      t.string :color
      t.integer :horsepower

      t.timestamps
    end
  end
end
