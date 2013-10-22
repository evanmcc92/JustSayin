class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :post
      t.string :posted_by
      t.integer :posted_by_uid

      t.timestamps
    end
  end
end
