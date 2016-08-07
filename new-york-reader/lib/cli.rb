require_relative "../lib/scraper.rb"
require_relative "../lib/article.rb"

class Cli
  attr_accessor :article_array

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
    puts "Please enter an article number to read a summary of that article, or 'all' to read summaries of all articles:"
    answer = gets.strip
  end

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
    answer = choose_summary_article
    if answer == "all"
      summarize_all
    else
      index = answer.to_i - 1
      puts "\n"
      puts @article_array[index][:title] + ", by " + @article_array[index][:author]
      puts "Published: " + @article_array[index][:date_time]
      puts @article_array[index][:summary]
    end
  end

  def read_article
    number = choose_read_article
    index = number.to_i - 1
    article_url = @article_array[index][:article_url]
    article = Article.new(article_url)
  end

  def summarize_all
    @article_array.each_with_index do |article, i|
      puts "\n"
      puts "#{i + 1}. " + article[:title] + ", by " + article[:author]
      puts "Published: " + article[:date_time]
      puts article[:summary]
    end
  end

  def list_or_exit

  end
# Xdisplay numbered list of all articles with summaries
# Xselect an article by number 
# Xdisplay description of article after selected by number
# Xdisplay full text article after selected by number
# launch article after selected by number
end

# module should include methods used by multiple classes (?)

cli = Cli.new
cli.numbered_list
cli.summary_or_article

