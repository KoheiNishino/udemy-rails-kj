# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :date
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  profile_photo   :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  # has_secure_passwordメソッド：モデルに記述して使用する。ただし、モデル内にpassword_digestという属性が含まれていることが使用条件。下記の3つの機能を使用できる。
  #  ・セキュアにハッシュ化したパスワードを、データベース内のpassword_digestという属性に保存できるようになる。
  #  ・2つのペアの仮想的な属性（passwordとpassword_confirmation）が使えるようになる。また、存在性と値が一致するかどうかのバリデーションも追加される 。
  #  ・authenticateメソッドが使えるようになる（引数の文字列がパスワードと一致するとUserオブジェクトを、間違っているとfalseを返すメソッド）。
  has_secure_password
  
  # validates：Active Recordの検証機能。
  #  presence：指定された属性が「空でない」ことを確認する。
  #  uniqueness：オブジェクトが保存される直前に、属性の値が一意（unique）であり重複していないことを検証する。
  #  length：属性の値の長さを検証する。
  #  format：withオプションで与えられた正規表現と属性の値がマッチするかどうかのテストによる検証する。デフォルトのエラーメッセージは「is invalid」。
  validates :name,
            presence: true,
            uniqueness: true,
            length: { maximum: 16 },
            format: {
              with: /\A[a-z0-9]+\z/,
              message: 'は小文字英数字で入力してください'
            }
  validates :password,
            length: { minimum: 8 },
            on: :create

  # Carrierwaveのアップローダーをモデルにマウント
  mount_uploader :profile_photo, ImageUploader
  
  # 生年月日から年齢を返す（RSpec用メソッド）
  def age
    # 現在時刻を保存する（フォーマットはconfig/time_format.rbに定義）
    now = Time.zone.now
    # 現在日時からユーザーの生年月日を引いて年齢を算出する（(20200901 - 19900101) / 10000 = 30.08歳）
    (now.strftime('%Y%m%d').to_i - birthday.strftime('%Y%m%d').to_i) / 10_000
  end
end
