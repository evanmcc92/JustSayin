class AddUpsAndDownsToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :up, :integer
    add_column :microposts, :down, :integer
  end
end
