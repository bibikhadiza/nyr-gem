require_relative "../lib/scraper.rb"
require_relative "../lib/article.rb" # doesn't work when i try to put it in enviro?

class Cli
  attr_accessor :article_array, :input

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
    puts "\n"
    puts "Here are the latest articles from The New Yorker website:"
    puts "\n"
    @article_array.each_with_index do |article_info, i|
      puts "#{i + 1}. #{article_info[:title]}"
    end
  end

  def choose_article
    puts "\n"
    puts "Please enter the number of an article you would like to read, or enter 'summaries' to display article summaries."
    puts "Type 'exit' to leave the program."
    answer = gets.strip
  end # for launch AND read in terminal

  # def choose_summary_article
  #   puts "\n"
  #   puts "Please enter an article number to read a summary of that article, or 'all' to read summaries of all articles:"
  #   answer = gets.strip
  # end # gets the axe if option to view individual summaries goes

  def summaries_or_read
    answer = choose_article
    if answer == "summaries"
      sum_one_or_all
    elsif answer.to_i.between?(1,10)
      read_article
    end
  end 

  def summary_prompt
    puts "\n"
    puts "Enter an article number to read a summary, or enter 'all' to list summaries of all articles."
    answer = gets.strip
  end

  def sum_one_or_all
    answer = summary_prompt
    if answer == "all"
      summarize_all
    elsif answer.to_i.between?(1,10)
      read_summary
    end
  end

  def read_summary
    index = @input.to_i - 1
    puts "\n"
    puts @article_array[index][:title] + ", by " + @article_array[index][:author]
    puts "Published: " + @article_array[index][:date_time]
    puts @article_array[index][:summary]
    read_now_or_exit
  end 

  def read_article
    index = @input.to_i - 1
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
    read_or_exit
  end

  def list_or_exit
    puts "\n"
    puts "Enter 'list' to display the list of articles again."
    puts "Type 'exit' to exit the program."
    answer = gets.strip
    if answer == "list"
      run_nyr
    end
  end

  def read_or_exit
    puts "\n"
    puts "Enter the number of an article to read it."
    puts "Type 'exit' to leave the program."
    answer = gets.strip
    if answer.to_i.between?(1,10)
      read_article
    end
  end

  def read_now_or_exit
    puts "\n"
    puts "Would you like to read this article, y/n?"
    answer = gets.strip
    if answer == "y"
      read_article
    elsif answer == "n"
      summaries_or_read
    end
  end

  def run_nyr
    numbered_list
    summaries_or_read
  end

end

# module should include methods used by multiple classes (?)

Cli.new


