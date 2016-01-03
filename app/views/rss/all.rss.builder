#encoding: UTF-8

xml.instruct! :xml, :version => '1.0'
xml.rss :version => '2.0' do
  xml.channel do
    xml.title 'Slashdot RSS feed, all feeds'
    xml.author 'slashdot-rss'
    xml.description 'All RSS Fees from slashdots last 7 days'
    xml.link 'http://no-url-yet/'
    xml.language 'en'

    @articles.each do |article|
      xml.item do
        if article.headline
          xml.title article.headline
        else
          xml.title ''
        end
        xml.author 'none defined'
        xml.pubDate article.published.to_s(:rfc822)
        xml.link article.url
        xml.guid article.id

        xml.description '<p>' + article.content + '</p>'
      end
    end
  end
end
