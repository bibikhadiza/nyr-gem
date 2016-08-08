require 'pry'
require 'nokogiri'
require 'open-uri'


  class Scraper

    URL = "http://www.newyorker.com/latest"


    def self.latest_page
      html = open(URL)
      doc = Nokogiri::HTML(html)
      article_array = []
      doc.css(".posts section").each do |article|
        hash = {}
        hash[:title] = article.css("h2 a").attribute("title").value
        hash[:time] = article.css("time").text
        hash[:summary] = article.css("p.p-summary").text
        hash[:article_url] = article.css("h2 a").attribute("href").value
        hash[:body] = self.article_page(hash[:url])
        hash[:author] = article.css("h3 span a").text
      article_array << hash
    end
      article_array
    end

    def self.scrape_article(article_url)
      html = open(article_url)
      doc = Nokogiri::HTML(html)
      doc.css("#articleBody.articleBody p")
    end

  end
