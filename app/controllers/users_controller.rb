class UsersController < ApplicationController
  # ユーザー登録画面を表示する
  def new
    # Userオブジェクトをインスタンス変数に格納する
    # コントローラー内で定義したインスタンス変数はビューで参照できる
    # 下記でユーザー登録に失敗した場合、flashで返されたUserオブジェクトの内容をフォームに表示する
    @user = User.new(flash[:user])
  end

  # ユーザー登録
  def create
    # StrongParametersで取得した値でUserオブジェクト初期化して、ローカル変数に格納する
    user = User.new(user_params)
    # DBにコミットする
    if user.save
      # コミット成功：セッションにuser.idを保存してマイページ画面にリダイレクトする
      session[:user_id] = user.id
      redirect_to mypage_path
    else
      # コミット失敗：flashでUserオブジェクトとエラーメッセージを返してユーザー登録画面にリダイレクトする
      redirect_back fallback_location: root_path, flash: {
        user: user,
        error_messages: user.errors.full_messages
      }
    end
  end

  # マイページ画面の表示
  def me; end

  # ユーザー情報の更新
  def update
    
    if @current_user.update(profile_photo: user_params[:profile_photo])
      
    else
      error = @current_user.errors.full_messages
    end

    redirect_to mypage_path
  end
  
  # 許可するパラメータはprivateメソッドでカプセル化する
  # createとupdateの両方で使いまわすことができる
  private

  # StrongPrameters
  #  require：POSTで受け取る値のキーを設定
  #  permit：許可するカラム指定
  def user_params
    params.require(:user).permit(:name, :password, :password_confirmation, :profile_photo)
  end
end
