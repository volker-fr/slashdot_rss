require 'slashdot_rss'
require 'pp'

namespace :slashdot do
  desc 'update all entries from the last 7 days'
  task update: :environment do
    SlashdotParseRss.new.pull_articles
  end

  desc 'delete the db'
  task clear_db: :environment do
    Article.delete_all
  end

  desc 'get articles from db'
  task get_articles: :environment do
    pp Article.all
  end
end
