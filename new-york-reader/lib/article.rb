require_relative "../lib/scraper.rb"

require_relative "scraper.rb"
require 'pry'

class Article

  attr_accessor :title, :author, :date, :body, :url, :summary

  @all = []


  def initialize(article_hash)
    article_hash.each {|key, value| self.send("#{key}=", value)}
    @all << self
  end


  def self.all
    @all
  end


  def self.create_from_collection(article_array)
    article_array.each do |article_hash|
      Article.new(article_hash)
    end
  end

  def organized_body(num)
    self.all[num].body.each do |paragraph|
      puts "\n"
      puts paragraph
      binding.pry
    end
  end

  def print
    puts "#{self.title}\n #{self.author}\n\n#{self.body}"
  end
 



end
