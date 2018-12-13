class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :website, :string
    add_column :users, :bio, :text
    add_column :users, :phonenumber, :string
  end
end
