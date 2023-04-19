class Report < ApplicationRecord
  # memberの区別がつかなくなるため,belongs_toで仮の名前,class_nameで本来のモデルを指定
  belongs_to :reporter, class_name: "Member"
  belongs_to :reported, class_name: "Member"
  validates :url, length: { minimum: 2, maximum: 50 }
  validates :reason, length: { minimum: 2, maximum: 200 }
  
  enum status: { wait: 0, keep: 1, finish: 2 }
end
