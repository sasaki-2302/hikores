# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 都道府県名データに北海道がなければ実行させる
unless Prefecture.exists?(name: '北海道')
# https://qiita.com/YoshikawaTakeshi/items/f9365175e5c77d67f6dc　参照
  require 'csv'

  # CSV読み込み
  file_path = 'lib/prefecture.csv'
  csv_data = CSV.read(file_path)

  # 都道府県データ抽出
  prefectures_list = csv_data.map { |row| row[1] }.uniq

  # 市区町村データ抽出
  cities_list = csv_data.map do |row|
      next if row[2] == nil
      row[1, 2]
    end.compact

  # 都道府県データ作成
  prefectures_list.each do |prefecture|
    Prefecture.create!(name: prefecture)
  end

  # 市区町村データ作成
  cities_list.each do |prefecture, city|
    prefecture = Prefecture.find_by(name: prefecture)
    prefecture.cities.create(name: city)
  end
end
# adminがいなければ実行させる
unless Admin.exists?(email: 'admin@a')
  Admin.create!(
    email: 'admin@a',
    password: '000001',
  )
end

# アドレスc@cのメンバーがいなければ実行させる
unless Member.exists?(email: 'c@c')
  Member.create!(
    name: 'test',
    email: 'c@c',
    password: 'cccccc',
  )
end
# テスト投稿データを作成
Post.create!(
  [
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[627].id, title: "徒歩圏に駅が複数ある", body: "交通の便が良い。徒歩圏内に地下鉄やJRの駅があり、行き先によって駅を選んで行動できる。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[627].id, title: "散歩、ジョギングコースが充実している", body: "皇居や日本武道館があり、早朝や深夜など自由に走ることができる。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[627].id, title: "土日は比較的空いている。", body: "オフィス街の為、土日はカフェや居酒屋など営業店が少ない。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[628].id, title: "新鮮な魚介類が手に入る", body: "築地市場があり、たくさんのお寿司屋さんが近くにある。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[628].id, title: "もんじゃで有名な月島", body: "月島は下町情緒があふれる街で、昔ながらの美味しい店を探す楽しさがある。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[628].id, title: "複数の路線が通っている", body: "電車や地下鉄だけでなくバスの路線も多く、利便性が高い。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[629].id, title: "大型スーパーが近くにない", body: "オフィス街のため、大型スーパーがなく物価も高いため自炊で節約するには厳しい。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[629].id, title: "有名な店が多い", body: "メディアで取り上げられるようなおしゃれなカフェやレストランが多い。 人気店は平日でも行列ができている。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[629].id, title: "治安が良い", body: "赤坂御所があり大使館なども多いため、パトロール中の警察官の姿をあちこちで見かける。 そのため安心して住む事ができる。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[630].id, title: "意外と自然豊か", body: "代々木公園や明治神宮があり、散歩やジョギングに向いている。住宅街に入ると静かな点も良い。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[630].id, title: "人が多い", body: "繁華街は観光客が多く人通りが多い。 24時間営業の店もあったりして場所によっては夜中もうるさいことがある。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[630].id, title: "韓国好きにはおすすめ", body: "新大久保は日本の韓国と呼ばれ、韓国料理や韓国コスメが手軽に入手できる。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[631].id, title: "歴史的建造物が多い", body: "湯島天神、小石川後楽園、伝通院など、多くの歴史的建造物がある。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[631].id, title: "住民の意識が高い", body: "清掃活動やボランティア活動が盛んで、住みやすい街づくりが行われている。" },
    {member_id: Member.first.id, prefecture_id: Prefecture.all[12].id, city_id: City.all[631].id, title: "アクセスが便利な場所に住める", body: "東京23区のほぼ中心に位置しているため都心へのアクセスが良い。区内には学校も多く、学生に人気のエリア。" }
  ]
)