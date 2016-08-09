<<<<<<< HEAD
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

  def self.formatted_body(index)
    puts "\n"
    puts self.all[index].title
    puts self.all[index].author
    puts self.all[index].time
    self.all[index].body.each do |p|
      puts "\n"
      puts p.text
    end
    puts "\n"
    puts "-End-"
  end

end
