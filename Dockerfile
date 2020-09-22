# ビルドを実行すると下記のDockerfileの内容を基にDockerImageが作成される
# Ruby2.4.5の実行環境のイメージをベースとする（リポジトリ:タグ）
FROM ruby:2.4.5
# コンテナを起動してパッケージをインストールする（Railsの動作に必要）
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get update && apt-get install -y \
    nodejs --no-install-recommends \
    graphviz \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*
# Ruby on Railsのプロジェクトファイルを作成するためのappディレクトリをコンテナ内に作成する
RUN mkdir /app
# 作業ディレクトリを設定
WORKDIR /app
# PC上にあるGemfileとGemfile.lockをappディレクトリ内にコピーする
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
# Gemのインストール
RUN bundle install
# Dockerfileに置いてあるフォルダの内容をすべてコンテナ内のappディレクトリ内にコピーする
COPY . /app
