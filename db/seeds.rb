# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# https://qiita.com/YoshikawaTakeshi/items/f9365175e5c77d67f6dc　参照
# CSVファイルを使用することを明示
require 'csv'

# 使用するデータ（CSVファイルの列）を指定
CSVROW_PREFNAME = 1
CSVROW_CITYNAME = 2

# CSVファイルを読み込み、DB（テーブル）へ保存
CSV.foreach('db/csv/prefecture.csv') do |row|
  city_name = row[CSVROW_CITYNAME]
  prefecture = Prefecture.create(:name => row[1])
  prefecture.save
  City.find_or_create_by(name: city_name, prefecture_id: prefecture.id)
end