require 'nokogiri'
require 'faraday'

# Download all articles from the last 7 days and parse content
class SlashdotParseRss
  def parse_posting(p)
    achievement = p.scan('<span class="ui-icon medal">').count
    comments =
      p.sub(%r{.*<span>([0-9]+)<span class="hide"> comments</span>.*}m, '\1')
    url = 'http:' + Nokogiri::HTML(p).css('a').attribute('href')
    headline = Nokogiri::HTML(p).css('a').text

    { 'url': url,
      'comments': comments,
      'achievement': achievement,
      'headline': headline }
  end

  def save_posting(posting)
    article = Article.find_by(url: posting[:url])
    if article.blank?
      # new article
      posting[:content], posting[:published] =
        get_article_details(posting[:url])
      Article.create!(posting)
    else
      # update existing article
      Article.update(article[:id], posting)
    end
  end

  def get_article_details(url)
    response = Faraday.get(url)
    doc = Nokogiri::HTML(response.body)
    content = doc.css('div.body')
    time = DateTime.parse(doc.css('div.details time').text)
    [content, time]
  end

  def pull_articles
    archive_url = 'http://slashdot.org/archive.pl'

    response = Faraday.get(archive_url)
    doc = Nokogiri::HTML(response.body)

    # Get all articles in an array
    archived_postings = doc.css('div.main-content').to_s.split('<br>')
    # first entry contains header, last entry is only a footer
    archived_postings.pop
    replace_first = archived_postings[0].sub(%r{.*</nav>}m, '')
    archived_postings.shift
    archived_postings.insert(0, replace_first)

    # Go through all postings and parse them
    archived_postings.each do |posting|
      save_posting(parse_posting(posting))
    end
  end
end
