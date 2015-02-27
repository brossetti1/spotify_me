class AddColumns < ActiveRecord::Migration
  def up
    add_column :users, :access_token, :string
    add_column :users, :refresh_token, :string
    add_column :users, :expire_token_time, :datetime
  end
end
