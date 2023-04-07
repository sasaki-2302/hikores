class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :member_id
      t.integer :prefecture_id
      t.integer :city_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
