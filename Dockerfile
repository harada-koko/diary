# 1. ベースイメージを指定
FROM ruby:3.4.4-slim

# 2. 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libyaml-dev

# 3. 作業ディレクトリを作成・設定
WORKDIR /rails

# Bundlerのキャッシュディレクトリへの書き込み権限を確保
# ここで/usr/local/bundleに書き込み権限を付与することで、rootユーザーがgemをキャッシュできるようになります。
# -p オプションでディレクトリが存在しない場合に作成
# -R オプションでサブディレクトリも再帰的に権限を設定
RUN mkdir -p /usr/local/bundle/cache && \
    chmod -R 777 /usr/local/bundle

# 4. Gemfileをコピーしてbundle installを実行
COPY Gemfile Gemfile.lock ./
RUN bundle install

# 5. ★★★ユーザー作成部分★★★
# 固定IDで`rails`という名前のグループとユーザーを作成
RUN groupadd -g 1000 rails
RUN useradd -u 1000 -g rails -m -s /bin/bash rails

# 6. アプリケーションのコードをコピー
COPY . .

# 7. エントリーポイントスクリプトをコピー
COPY docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# 8. ポートを公開
EXPOSE 3000

# 9. 作成したユーザーとして、サーバーを起動
USER rails
CMD ["rails", "server", "-b", "0.0.0.0"]