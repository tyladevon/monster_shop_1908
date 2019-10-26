class AddMerchantsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :merchant, foreign_key: true, default: nil
  end
end
