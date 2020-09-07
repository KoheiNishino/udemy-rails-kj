# 掲示板アプリケーション
## 概要
Udemy「[フルスタックエンジニアが教える 即戦力Railsエンジニア養成講座](https://www.udemy.com/course/rails-kj/)」で作成した掲示板アプリケーション。

## 機能一覧
* 掲示板新規作成・編集・削除
* ページネーション(kaminari)
* コメント投稿・削除（1対多のアソシエーション）
* タグによる掲示板表示の絞り込み（多対多のアソシエーション）
* ユーザー認証(Cookie, bcrypt)
* RSpecを使用したテスト(一部のモデル・コントローラーが対象)

## 使用技術
### 言語・フレームワーク
Ruby 2.4.5 | Ruby on Rails 5.2.2  
Bootstrap 4.0.0

### データベース
MySQL 5.7

### ER図
![erd](https://user-images.githubusercontent.com/58029195/92374465-b547cc00-f13a-11ea-9d86-2a2060313d69.png)