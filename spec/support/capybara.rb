require 'capybara/rspec'
require 'selenium-webdriver'

# Capybaraに、remote_chromeという名前のdriverを登録する
Capybara.register_driver :remote_chrome do |app|
  options = {
    browser: :remote,
    # remote browserが動作しているurlを指定
    # 今回は`chrome`という名前で`docker-compose.yml`に登録したのでhost名は`chrome`
    url: 'http://test-browser:4444/wd/hub',
    capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
      # 各設定はここを参照: https://peter.sh/experiments/chromium-command-line-switches/
      'goog:chromeOptions': {
        args: %w[
          headless
          disable-gpu
          window-size=1400,2000
          no-sandbox
        ]
      }
    )
  }

  Capybara::Selenium::Driver.new(app, options)
end

# javascript_driverに上で登録したremote_chromeを指定する
Capybara.javascript_driver = :remote_chrome

# Capybaraはtestのためにサーバーを起動する。rails-rspecを用いているなら、railsが起動する。
# 以下のコマンドが実行されるイメージ
# rails s -b {Capybara.server_host} -p {Capybara.server_port}
# `Capybara.server_host`にサーバーが起動するhostを指定する。別のホストのブラウザからアクセス可能にするため、`0.0.0.0`を指定する。
# `Capybara.server_port`にサーバーがlistenするportを指定する。portを指定しないとランダムなポートで起動するので適当な値を指定する必要がある。
# ref: https://github.com/teamcapybara/capybara/blob/a5b5a04d81e1138d6904e33ac176227d04aacce9/lib/capybara.rb#L98-L99
Capybara.server_host = '0.0.0.0'
Capybara.server_port = '9999'

# `Capybara.app_host`に`chrome`コンテナで動作するブラウザにアクセスしてほしいurlを指定する
# Capybaraが立ち上げるサーバーのURLを指定すれば良い。ただし、`chrome`コンテナが解決できるようなurlを指定する必要がある。
# `visit`メソッドに相対パスが渡された時、この値がbase urlになる。
# つまり、`visit('/hoge')` = `visit("#{Capybara.app_host}/hoge")`
# ref: https://www.rubydoc.info/gems/capybara/Capybara%2FSession:visit
# `IPSocket.getaddress(Socket.gethostname)`は自身のipアドレスを返す。
# ref: https://github.com/teamcapybara/capybara/blob/a5b5a04d81e1138d6904e33ac176227d04aacce9/lib/capybara.rb#L75
Capybara.app_host = "http://#{IPSocket.getaddress(Socket.gethostname)}:#{Capybara.server_port}"
