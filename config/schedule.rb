# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# https://qiita.com/Tanesaka/items/74d608d4d1a8a6c0a47a　参照
# Rails.rootを使用するために必要
require File.expand_path(File.dirname(__FILE__) + "/environment")
# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development
# cronを実行する環境変数をセット
set :environment, rails_env
# cronのログの吐き出し場所
# set :output, "#{Rails.root}/log/cron.log"

#10分に一度、data_resetメソッドを実行　ログは生成しないようにする
every 10.minute do
  # begin
    runner "Member.data_reset"
  # rescue => e
  #   Rails.logger.error("aborted rails runner")
  #   raise e
  # end
end