# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  body       :text(65535)
#  name       :string(255)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Board < ApplicationRecord
  # has_many :through：多対多のつながりを設定。2つのモデルの間に第3のモデルが介在する。
  # dependent：オーナーオブジェクトがdestroyされたときに、オーナーに関連付けられたオブジェクトをどうするかを制御する。
  has_many :comments, dependent: :delete_all
  has_many :board_tag_relations, dependent: :delete_all
  has_many :tags, through: :board_tag_relations

  # validates：Active Recordの検証機能。
  #  presence：指定された属性が「空でない」ことを確認する。
  #  length：属性の値の長さを検証する。
  validates :name, presence: true, length: { maximum: 10 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 1000 }
end
