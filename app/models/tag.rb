# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  # has_many :through：多対多のつながりを設定。2つのモデルの間に第3のモデルが介在する。
  # dependent：オーナーオブジェクトがdestroyされたときに、オーナーに関連付けられたオブジェクトをどうするかを制御する。
  has_many :board_tag_relations, dependent: :delete_all
  has_many :boards, through: :board_tag_relations
end
