require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # GETメソッドでアクセスが来た場合のUserコントローラーのnewアクションをテスト対象とする
  describe 'GET #new' do
    # beforeブロックには、コントローラーのnewアクションにGETのHTTPメソッドでアクセスすることを擬似的に行っている。
    # これによりGETのリクエスト結果がresponseという変数に格納される。
    before { get :new }

    # マッチャ（matcher）：「期待値と実際の値を比較して、一致した（もしくは一致しなかった）という結果を返すオブジェクト」のこと。
    # have_http_status：HTTPステータスの値を検証する。
    it 'レスポンスコードが200(OK)であること' do
      expect(response).to have_http_status(:ok)
    end

    # render_template：どのテンプレート(*.html.erb)が描画されたかを検証する。
    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    # be_a_new：作成、保存されたインスタンス変数の型が同じかどうか検証する。
    # assignsメソッド：コントローラー内で使用したインスタンス変数を参照できる。
    it '新しいuserオブジェクトがビューに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  # POSTメソッドでアクセスが来た場合のUserコントローラーのcreateアクションをテスト対象とする。
  describe 'POST #create' do
    # テスト実行時の準備
    before do
      # リファラー：あるWebページのリンクをクリックして別のページに移動したときの、リンク元のページのこと。
      # テストケースの場合はリファラーの情報がないため、redirect_to_backを実行するとエラーとなる。
      # そのため、明示的にリクエストのHTTPヘッダにリファラーを設定する必要がある。
      @referer = 'http://localhost'
      @request.env['HTTP_REFERER'] = @referer
    end

    # 正常系のテスト
    context '正しいユーザー情報が渡ってきた場合' do
      # 正しいユーザー情報を持つユーザーを作成する。
      let(:params) do
        { user: {
          name: 'user',
          password: 'password',
          password_confirmation: 'password'
        } }
      end

      # 正しいユーザー情報を持つユーザーをポストする。
      # change：ブロックの実行前後の対象の値の変化を検証する。
      # byメソッド：増減値を指定する。
      it 'ユーザーが1人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      # redirect_to：リダイレクト先をを検証する。
      it 'マイページにリダイレクトされること' do
        expect(post(:create, params: params)).to redirect_to(mypage_path)
      end
    end

    # 異常系のテスト
    context 'パラメータに正しいユーザー名、確認パスワードが含まれていない場合' do
      # テスト実行時の準備
      before do
        # 正しくないユーザー情報（パスワードと確認用パスワードが不一致）を持つユーザーをポストする。
        post(:create, params: {
               user: {
                 name: 'ユーザー1',
                 password: 'password',
                 password_confirmation: 'invalid_password'
               }
             })
      end

      # redirect_to：リダイレクト先をを検証する。
      it 'リファラーにリダイレクトされること' do
        expect(response).to redirect_to(@referer)
      end

      # include：特定の値が含まれていることを検証する。
      it 'ユーザー名のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      # include：特定の値が含まれていることを検証する。
      it 'パスワード確認のエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'パスワード（確認）とパスワードの入力が一致しません'
      end
    end
  end
end
