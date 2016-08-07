require_relative "../lib/scraper.rb"
require_relative "../lib/article.rb"

class Cli
  attr_accessor :article_array

  def initialize
    @article_array = Scraper.scrape_latest
  end

  def greeting
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
  end # gets the axe if option to view individual summaries goes

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
  end # not very intuitive, think about how to change

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
      list_or_exit
    end
  end # get rid of this and just list all summaries?

  def read_article
    number = choose_read_article
    index = number.to_i - 1
    article_url = @article_array[index][:article_url]
    article = Article.new(article_url)
    list_or_exit
  end

  def summarize_all
    @article_array.each_with_index do |article, i|
      puts "\n"
      puts "#{i + 1}. " + article[:title] + ", by " + article[:author]
      puts "Published: " + article[:date_time]
      puts article[:summary]
    end
    list_or_exit
  end

  def list_or_exit
    puts "\n"
    puts "Enter 'list' to return to the list of articles."
    puts "Enter 'exit' to exit the program."
    answer = gets.strip
    if answer == "list"
      run_nyr
    end
  end

  def run_nyr
    greeting
    numbered_list
    summary_or_article
  end

end

# module should include methods used by multiple classes (?)

cli = Cli.new
cli.run_nyr # weird that list appears after list of summaries and summary of indiv article

