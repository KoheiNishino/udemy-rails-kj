# 掲示板アプリケーション
## 概要
Udemy「[フルスタックエンジニアが教える 即戦力Railsエンジニア養成講座](https://www.udemy.com/course/rails-kj/)」で作成した掲示板アプリケーション。  
インフラ側のリポジトリは[コチラ](https://github.com/KoheiNishino/udemy-rails-kj-infra)。

## 機能一覧
* 掲示板新規作成・編集・削除
* ページネーション（kaminari）
* コメント投稿・削除（1対多のアソシエーション）
* タグによる掲示板表示の絞り込み（多対多のアソシエーション）
* ユーザー認証（Cookie, bcrypt）
* プロフィール画像設定（carrierwave, mini_magick）
* RSpecを使用したテスト（一部のモデル・コントローラーが対象）

## 使用技術
### 言語・フレームワーク
Ruby 2.4.5 | Ruby on Rails 5.2.2  
Bootstrap 4.0.0

### Webサ−バー・アプリケーション・サーバー
NginX 1.18.0 | Puma 3.0

### データベース
MySQL 5.7

### システム構成図
![rails-kj](https://user-images.githubusercontent.com/58029195/92391030-ee8e3500-f156-11ea-9527-ea2b6bfeb18b.png)

### ER図
![erd](https://user-images.githubusercontent.com/58029195/93851876-e6ec9580-fceb-11ea-8a0c-1ccbc7ea4e6a.png)