
require_relative '../config/environment'
require 'launchy'
require 'ruby-progressbar'
require 'colored'


class Cli
  attr_accessor :input

  def initialize
    greeting
    make_articles
    run_nyr
  end

  def greeting
    puts "\n"
    puts "* * * Welcome to The New Yorker Reader! * * *"
  end

  def make_articles
    article_array = Scraper.scrape_latest
    Article.create_from_collection(article_array)
  end

  def run_nyr
    numbered_list
    choose_menu_option
  end


  def numbered_list
    puts "\n"
    puts "Here are the latest articles from The New Yorker website:"

    progress = ProgressBar.create(:format => "%p%% %b",:progress_mark  => ".",:remainder_mark => "\u{FF65}",:starting_at => 0)
    100.times { progress.increment; sleep 0.01 }

    puts "\n"
    Article.all.each_with_index do |article, i|
      puts "#{i + 1}. #{article.title}"
    end
  end



  def choose_article
    puts "\n"
    puts "Please enter an article number to begin."
    gets.strip
  end


  def menu
    summary_prompt
    read_prompt
    launch_prompt
    gets.strip
  end


  def choose_menu_option
    @input = choose_article
    choice = menu
    if choice == "s"
      read_summary
    elsif choice == "r"
      read_article
    elsif choice == "l"
      launch_article
    else
      invalid
      choice
    end
  end

  def summary_prompt
    puts "Enter 's' if you would like to see a summary of this article."
  end

  def read_prompt
    puts "Enter 'r' to read this article here."
  end

  def launch_prompt
    puts "Enter 'l' to launch this article in your browser."
  end

  def exit_prompt
    puts "Type 'exit' if you would like to exit the program."
  end

  def list_prompt
    puts "Enter 'list' to display a list of the latest articles again."
  end

  def read_summary
    index = @input.to_i - 1
    puts "\n"
    puts Article.all[index].title
    puts Article.all[index].author
    puts "Published: " + Article.all[index].time
    puts Article.all[index].summary
    from_summary
  end

 def from_summary
    puts "\n"
    read_prompt
    launch_prompt
    list_prompt
    exit_prompt
    answer = gets.strip
    if answer == "r"
      read_article
    elsif answer == "l"
      launch_article
    elsif answer == "list"
      run_nyr
    elsif answer != "exit"
      invalid
      from_summary
    end
  end


  def read_article
    index = @input.to_i - 1
    article = Article.all[index]
    article.format_body
    from_read
  end


  def launch_article
    index = @input.to_i - 1
    url = Article.all[index].article_url
    Launchy.open(url)
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
  end

  def from_read
    puts "\n"
    launch_prompt
    list_prompt
    exit_prompt
    answer = gets.strip
    if answer == "l"
      launch_article
    elsif answer == "list"
      run_nyr
    elsif answer != "exit"
      invalid
      from_read
    end
  end

  def from_launch
    puts "\n"
    run_nyr
  end


  def invalid
    puts "\n"
    puts "Please enter a valid command."
  end


end
