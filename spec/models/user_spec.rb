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
require 'rails_helper'

RSpec.describe User, type: :model do
  # Userモデルのageメソッドをテスト対象とする
  describe '#age' do
    # テスト実行前の準備
    before do
      # allow(モックオブジェクト).to receive(メソッド名) の形で、モックに呼び出し可能なメソッドを設定できる
      # Time.zoneオブジェクトでnowメソッドが呼ばれた場合、parseメソッドで2018/04/01のオブジェクトを返す
      allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2018/4/01'))
    end

    context '20年前の生年月日の場合' do
      # letブロックでブロック内の評価結果を取得する
      # 誕生日が現在日時（2018/04/01）の20年前の日時のユーザーを作成する
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }

      # itブロックでageメソッドを呼び出して結果が妥当であることを確認する
      it '年齢が20歳であること' do
        expect(user.age).to eq 20
      end
    end

    context '10年前に生まれた場合でちょうど誕生日の場合' do
      # 誕生日が2008/04/01のユーザーを作成する
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/01')) }

      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end

    context '10年前に生まれた場合で誕生日が来ていない場合' do
      # 誕生日が2008/04/02のユーザーを作成する
      let(:user) { User.new(birthday: Time.zone.parse('2008/04/02')) }

      # 現在(2018/04/01)の年齢は9歳であること
      it '年齢が9歳であること' do
        expect(user.age).to eq 9
      end
    end
  end
end
