class Relationship < ApplicationRecord
  # memberの区別がつかなくなるため,belongs_toで仮の名前,class_nameで本来のモデルを指定
  belongs_to :follower, class_name: "Member"
  belongs_to :followed, class_name: "Member"
end
