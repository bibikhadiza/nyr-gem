require_relative "../lib/scraper.rb"
require_relative "../lib/article.rb" # doesn't work when i try to put it in enviro?

class Cli
  attr_accessor :input

  def initialize
    greeting
    make_articles
    run_nyr
  end

  def make_articles
    article_array = Scraper.scrape_latest
    Article.create_from_collection(article_array)
  end

  def greeting
    puts "\n"
    puts "* * * Welcome to The New Yorker Reader! * * *"
  end

  def numbered_list
    puts "\n"
    puts "Here are the latest articles from The New Yorker website:"
    puts "\n"
    Article.all.each_with_index do |article, i|
      puts "#{i + 1}. #{article.title}"
    end
  end

  def choose_article
    puts "\n"
    puts "Please enter the number of an article you would like to read, or enter 'summaries' to display article summaries."
    puts "Type 'exit' to exit the program."
    gets.strip
  end # for launch AND read in terminal

  def summaries_or_read
    @input = choose_article
    if @input == "summaries"
      sum_one_or_all
    elsif @input.to_i.between?(1,10)
      read_article
    end
  end 

  def summary_prompt
    puts "\n"
    puts "Enter an article number to read a summary, or enter 'all' to display summaries of all articles."
    gets.strip
  end

  def sum_one_or_all
    @input = summary_prompt
    if @input == "all"
      summarize_all
    elsif @input.to_i.between?(1,10)
      read_summary
    end
  end

  def read_summary
    index = @input.to_i - 1
    puts "\n"
    puts Article.all[index].title 
    puts Article.all[index].author
    puts "Published: " + Article.all[index].time
    puts Article.all[index].summary
    read_now
  end 

  def read_article
    index = @input.to_i - 1
    Article.formatted_body(index)
    list_or_exit
  end

  def summarize_all
    Article.all.each_with_index do |article, i|
      puts "\n"
      puts "#{i + 1}. " + article.title
      puts article.author
      puts "Published: " + article.time
      puts article.summary
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
    puts "Type 'exit' to exit the program."
    @input = gets.strip
    if @input.to_i.between?(1,10)
      read_article
    end
  end

  def read_now
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

Cli.new


