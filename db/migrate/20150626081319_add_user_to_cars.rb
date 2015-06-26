class AddUserToCars < ActiveRecord::Migration
  def change
    add_column :cars, :user_id, :integer, references: :users
  end
end
