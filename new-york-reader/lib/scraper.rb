<<<<<<< HEAD
require 'pry'
require 'nokogiri'
require 'open-uri'


class Scraper

URL = "http://www.newyorker.com/latest"
=======
class Scraper

  URL = "http://www.newyorker.com/latest"
>>>>>>> ceac9c05c18738524d71baa93a085d5bac6b28fd

  def self.scrape_latest
    html = open(URL)
    doc = Nokogiri::HTML(html)
<<<<<<< HEAD

    article_array = []
      doc.css(".posts section").each do |article|
        hash = {}
        hash[:title] = article.css("h2 a").attribute("title").value
        hash[:author] = article.css("h3").text.gsub(/\s+/, " ")
        hash[:time] = article.css("time").text
        hash[:summary] = article.css("p.p-summary").text
        hash[:article_url] = article.css("h2 a").attribute("href").value
        hash[:body] = self.scrape_article(hash[:article_url])
        article_array << hash
      end
        article_array
  end

  def self.scrape_article(article_url)
  html = open(article_url)
  doc = Nokogiri::HTML(html)
  doc.css("#articleBody.articleBody p")
  end

=======
   
    article_array = []
    doc.css(".posts section").each do |article|
      hash = {}
      hash[:title] = article.css("h2 a").attribute("title").value
      hash[:author] = article.css("h3").text.gsub(/\s+/, " ")
      hash[:time] = article.css("time").text
      hash[:summary] = article.css("p.p-summary").text
      hash[:article_url] = article.css("h2 a").attribute("href").value
      hash[:body] = self.scrape_article(hash[:article_url])

      article_array << hash
    end
    
    article_array
  end

  def self.scrape_article(article_url)
    html = open(article_url)
    doc = Nokogiri::HTML(html)

    doc.css("#articleBody.articleBody p")
  end
  
>>>>>>> ceac9c05c18738524d71baa93a085d5bac6b28fd
end
