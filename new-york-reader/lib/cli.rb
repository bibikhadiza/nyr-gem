require_relative "../lib/scraper.rb"
require_relative "../lib/article.rb"

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

  def choose_read_article
    puts "\n"
    puts "Please enter the number of the article you would like to read:"
    answer = gets.strip
  end # for launch AND read in terminal

  def choose_summary_article
    puts "\n"
    puts "Please enter an article number to read a summary of that article:"
    answer = gets.strip
  end # for description

  def summary_or_article
    puts "\n"
    puts "\n"
    puts "Please enter 'summary' to read a summary of an article."
    puts "Enter 'read' to read an article."
    answer = gets.strip
    if answer == "summary"
      read_summary
    elsif answer == "read"
      read_article
    end
  end

  def read_summary
    number = choose_summary_article
    index = number.to_i - 1
    puts "\n"
    puts Scraper.scrape_latest[index][:title] + ", by " + Scraper.scrape_latest[index][:author]
    puts "Published: " + Scraper.scrape_latest[index][:date_time]
    puts Scraper.scrape_latest[index][:summary]
  end

  def read_article
    number = choose_read_article
    index = number.to_i - 1
    article_url = Scraper.scrape_latest[index][:article_url]
    article = Article.new(article_url)
  end
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
cli.summary_or_article

