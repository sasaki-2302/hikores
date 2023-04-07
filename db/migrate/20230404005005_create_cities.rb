class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.integer :prefecture_id
      t.integer :name

      t.timestamps
    end
  end
end
