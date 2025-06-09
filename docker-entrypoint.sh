#!/bin/sh
set -e

# Railsのserver.pidがもし残っていたら削除する
if [ -f /rails/tmp/pids/server.pid ]; then
  rm /rails/tmp/pids/server.pid
fi

# DockerfileのCMDで渡されたコマンドを実行する
exec "$@"