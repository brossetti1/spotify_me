class DropTableVetos < ActiveRecord::Migration
  def change
    drop_table :vetos
  end
end
