class SessionsController < ApplicationController
  # ログイン
  def create
    # Userモデルからフォームに入力されたユーザー名に一致するユーザーを取得する
    user = User.find_by(name: params[:session][:name])
    # Userモデルから取得したユーザーのPWとparamsのPWと一致するかを検証する
    # &.：userがnilの場合にNoMethodErrorを回避してnilを返す
    if user&.authenticate(params[:session][:password])
      # 認証が一致した場合 → セッションオブジェクトにログインするユーザーのidを保存し、マイページにリダイレクトする
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      # 認証が失敗した場合 → ログイン画面を表示する
      render 'home/index'
    end
  end

  # ログアウト
  def destroy
    # セッションオブジェクトからログイン中のユーザーのidを削除する
    session.delete(:user_id)
    # ホーム画面にリダイレクトする
    redirect_to root_path
  end
end
