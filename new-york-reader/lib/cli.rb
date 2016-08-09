
require_relative '../config/environment'

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
    puts "Please enter an article number to begin."
    exit_prompt
    gets.strip
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

  def menu
    puts "\n"
    puts "-Menu-"
    summary_prompt
    read_prompt
    launch_prompt
    exit_prompt
    gets.strip
  end

  def choose_menu_option
    @input = choose_article # way to check if valid
    choice = menu
    if choice == "s"
      read_summary
    elsif choice == "r"
      read_article
    elsif choice == "l"
      launch_article
    elsif choice != "exit"
      invalid
      choose_option
    end
  end

  def launch_article
    index = @input.to_i - 1
    Launchy.open("#{Article.all[index].article_url}")
    from_launch
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

  def read_article
    index = @input.to_i - 1
    article = Article.all[index]
    article.format_body
    from_read
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

  # def summarize_all
  #   Article.all.each_with_index do |article, i|
  #     puts "\n"
  #     puts "#{i + 1}. " + article.title
  #     puts article.author
  #     puts "Published: " + article.time
  #     puts article.summary
  #   end
  #   read_or_exit
  # end

  def from_launch
    puts "\n"
    run_nyr
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

  def run_nyr
    numbered_list
    choose_menu_option
  end

  def invalid
    puts "\n"
    puts "Please enter a valid command."
  end

end