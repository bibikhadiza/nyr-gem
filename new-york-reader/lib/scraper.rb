require_relative '../config/environment'

class Scraper

  URL = "http://www.newyorker.com/latest"

  def self.scrape_latest
    html = open(URL)
    doc = Nokogiri::HTML(html)
   
    articles = []
    doc.css(".posts section").each do |article|
      hash = {}
      hash[:title] = article.css("h2 a").attribute("title").value
      hash[:author] = article.css("h3 span a").text
      hash[:date_time] = article.css("span.timestamp").text.strip
      hash[:summary] = article.css("p.p-summary").text
      hash[:article_url] = article.css("h2 a").attribute("href").value
      hash[:body] = self.scrape_article(hash[:article_url])

      articles << hash
    end
    # binding.pry
    articles
  end

  def self.scrape_article(article_url)
    html = open(article_url)
    doc = Nokogiri::HTML(html)

    doc.css("#articleBody.articleBody p")

    # full_text_hash = {}
    # # full_text_hash[:title] = doc.css("h1.title").text
    # # full_text_hash[:author] = doc.css("h3 span a").text
    # full_text_hash[:body] = doc.css("#articleBody.articleBody p")
    # # full_text_hash[:time] = doc.css("time.blog-post-date").text
    # # full_text_hash
    # full_text_hash[:body]
  end
  
end
