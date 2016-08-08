require 'pry'
require 'nokogiri'
require 'open-uri'



class Scraper

  URL = "http://www.newyorker.com/latest"


  def self.latest_page
    html = open(URL)
    doc = Nokogiri::HTML(html)
    articles = []
    doc.css(".posts section").each do |article|
      hash = {}
    hash[:title] = article.css("h2 a").attribute("title").value
    hash[:date] = article.css("time").text
    hash[:summary] = article.css("p.p-summary").text
    hash[:url] = article.css("h2 a").attribute("href").value
    articles << hash
  end
    articles
    binding.pry
  end

  def self.non_latest_page(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    article_hash = {}
    article_hash[:title] = doc.css("h1.title").text
    article_hash[:author] = doc.css("h3.contributors").text
    article_hash[:date] = doc.css("time.blog-post-date").attribute("content").value
    article_hash[:body] = doc.css("#articleBody.articleBody p").text
    article_hash
  end
  #finished scraper



end

Scraper.non_latest_page("http://www.newyorker.com/culture/photo-booth/seeing-beyond-the-bag-lady")
