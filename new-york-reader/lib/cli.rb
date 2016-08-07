require_relative "../lib/scraper.rb"

class Cli
  attr_accessor :article_array
  # menu?

  def initialize
    @article_array = Scraper.scrape_latest
    puts "\n"
    puts "Welcome to The New Yorker Reader!"
    puts "\n"
    puts "Here are the latest articles from The New Yorker website:"
    puts "\n"
  end

  def numbered_list
    @article_array.each_with_index do |article_info, i|
      puts "#{i + 1}. #{article_info[:title]}"
    end
  end

  def choose_article
    puts "\n"
    puts "Please enter the number of the article you would like to read:"
    answer = gets.strip
    index = answer.to_i + 1
  end # for launch AND read in terminal

  def choose_describe_article
    puts "\n"
    puts "Please enter an article number to read a summary of that article:"
    answer = gets.strip
    index = answer.to_i + 1
  end # for description

# display numbered list of all articles with summaries
# display numbered list of all articles with authors
# display numbered list of all articles with summaries and authors
# select an article by number 
# display description of article after selected by number
# display full text article after selected by number
# launch article after selected by number
end

# module should include methods used by multiple classes (?) 

cli = Cli.new
cli.numbered_list
