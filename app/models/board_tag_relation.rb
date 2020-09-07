# == Schema Information
#
# Table name: board_tag_relations
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  board_id   :integer
#  tag_id     :integer
#
class BoardTagRelation < ApplicationRecord
  # belongs_to：1対1のつながりを設定。他方のモデルのインスタンスに従属する。
  belongs_to :board
  belongs_to :tag
end
