class ApplicationController < ActionController::Base
  # CSRF対応
  protect_from_forgery with: :exception
  # ApplicationControllerはすべてのコントローラーで継承されているため、
  # すべてのアクションの実行前にcurrent_userメソッドを実行する
  before_action :current_user

  private

  # ログイン中のユーザーを取得
  def current_user
    # セッションにuser.idが保存されていなければリターンする
    return unless session[:user_id]

    # セッションに保存されているuser.idに一致するユーザーをUserモデルから取得してインスタンス変数に格納する
    @current_user = User.find_by(id: session[:user_id])
  end
end
