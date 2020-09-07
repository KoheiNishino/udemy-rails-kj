# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text(65535)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#
class Comment < ApplicationRecord
  # belongs_to：1対1のつながりを設定。他方のモデルのインスタンスに従属する。
  belongs_to :board

  # validates：Active Recordの検証機能。
  #  presence：指定された属性が「空でない」ことを確認する。
  #  length：属性の値の長さを検証する。
  validates :name, presence: true, length: { maximum: 10 }
  validates :comment, presence: true, length: { maximum: 1000 }
end
