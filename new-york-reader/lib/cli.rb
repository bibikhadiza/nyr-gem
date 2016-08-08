require_relative "../lib/scraper.rb"
require_relative "../lib/article.rb" # doesn't work when i try to put it in enviro?

class Cli
  attr_accessor :article_array

  def initialize
    @article_array = Scraper.scrape_latest
    greeting
    run_nyr
  end

  def greeting
    puts "\n"
    puts "* * * Welcome to The New Yorker Reader! * * *"
    puts "\n"
  end

  def numbered_list
    puts "Here are the latest articles from The New Yorker website:"
    puts "\n"
    @article_array.each_with_index do |article_info, i|
      puts "#{i + 1}. #{article_info[:title]}"
    end
  end

  def choose_article
    puts "\n"
    puts "Please enter the number of an article you would like to explore, or enter 'summaries' to see summaries of all articles."
    puts "Type 'exit' to leave the program."
    answer = gets.strip
  end # for launch AND read in terminal

  # def choose_summary_article
  #   puts "\n"
  #   puts "Please enter an article number to read a summary of that article, or 'all' to read summaries of all articles:"
  #   answer = gets.strip
  # end # gets the axe if option to view individual summaries goes

  def summary_or_read
    number = choose_article
    if number == "summaries"
      summarize_all
    elsif number.to_i.between?(1,10)
      puts "\n"
      puts "Please enter 'summary' to read a summary of the article."
      puts "Enter 'read' to read the article."
      answer = gets.strip
      if answer == "summary"
        read_summary(number)
      elsif answer == "read"
        read_article(number)
      end
    end
  end 

  def read_summary(number)
    index = number.to_i - 1
    puts "\n"
    puts @article_array[index][:title] + ", by " + @article_array[index][:author]
    puts "Published: " + @article_array[index][:date_time]
    puts @article_array[index][:summary]
    list_or_exit
  end 

  def read_article(number)
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
    puts "Enter 'list' to display the list of articles."
    puts "Type 'exit' to exit the program."
    answer = gets.strip
    if answer == "list"
      run_nyr
    end
  end

  def run_nyr
    numbered_list
    summary_or_read
  end

end

# module should include methods used by multiple classes (?)

cli = Cli.new


