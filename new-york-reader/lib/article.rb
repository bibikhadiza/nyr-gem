require_relative "../lib/scraper.rb"

class Article
  attr_accessor :title, :author, :body, :date_time, :summary, :article_url

  @@all = []

  def initialize(article_hash)
    article_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
    # article = Scraper.scrape_article(article_url)
    # puts "\n"
    # puts article[:title]
    # puts "By " + article[:author]
    # puts "\n"
    # puts "Published: " + article[:time]
    # puts formatted_body(article)
    # puts "\n"
  end

  def self.create_from_collection(article_array)
    article_array.each do |article_hash|
      Article.new(article_hash)
    end
  end

  def self.all
    @@all
  end

  def self.formatted_body(index)
    self.all[index].body.each do |p|
      puts "\n"
      puts p.text
    end
    # self.body.each do |paragraph|
    #   puts "\n"
    #   puts paragraph.text
    # end
    # puts "\n" + "-End-"
  end

end

