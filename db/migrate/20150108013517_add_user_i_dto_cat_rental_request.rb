class AddUserIDtoCatRentalRequest < ActiveRecord::Migration
  def change
    add_column :cat_rental_requests, :user_id, :integer
    change_column :cat_rental_requests, :user_id, :integer, null: false
  end
    
end
