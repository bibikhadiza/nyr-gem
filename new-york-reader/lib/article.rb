
require_relative "../lib/scraper.rb"

require_relative "scraper.rb"
require 'pry'



class Article
  attr_accessor :title, :author, :body, :time, :summary, :article_url

  @@all = []

  def initialize(article_hash)
    article_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(article_array)
    article_array.each do |article_hash|
      Article.new(article_hash)
    end
  end

  def self.all
    @@all
  end

  def format_body
      puts "\n"
      puts self.title  #it is the Cli's responsibilty to parse the article
      puts self.author
      puts self.time
      self.body.each do |p|
        puts "\n"
        puts p
      end
      puts "\n"
      puts "-End-"
    end

end
