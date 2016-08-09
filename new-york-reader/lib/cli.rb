
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
    puts "Enter the number of an article you would like to explore."
    puts "Type 'exit' to exit the program."
    gets.strip
  end 

  def menu
    puts "\n"
    puts "-Menu-"
    puts "Enter 's' if you would like to see a summary of this article before committing to read it."
    puts "Enter 'r' to read the article here."
    puts "Enter 'l' to launch the article in your browser."
    puts "Type 'exit' to exit the program."
    gets.strip
  end

  def choose_menu_option
    @input = choose_article # way to check if valid
    choice = menu
    if choice == 's'
      read_summary
    elsif choice == 'r'
      read_article
    elsif choice == 'l'
      launch_article
    elsif choice != 'exit'
      invalid
      choose_option
    end
  end


  # def summaries_or_read
  #   @input = choose_article
  #   if @input == "summaries"
  #     sum_one_or_all
  #   elsif @input.to_i.between?(1,10)
  #     read_or_launch
  #   elsif @input != "exit"
  #     invalid
  #     summaries_or_read
  #   end
  # end 

  # def read_or_launch
  #   puts "\n"
  #   puts "Enter 'read' if you would like to read this article here."
  #   puts "Enter 'launch' if you would like to launch this article in your browser."
  #   answer = gets.strip
  #   if answer == "read"
  #     read_article
  #   elsif answer == "launch"
  #     launch_article
  #   else 
  #     invalid
  #     read_or_launch
  #   end
  # end

  def launch_article
    index = @input.to_i - 1
    Launchy.open("#{Article.all[index].article_url}")
    list_or_exit
  end

  # def summary_prompt
  #   puts "\n"
  #   puts "Enter an article number to read a summary of it, or enter 'all' to display summaries of all articles."
  #   gets.strip
  # end

  # def sum_one_or_all
  #   @input = summary_prompt
  #   if @input == "all"
  #     summarize_all
  #   elsif @input.to_i.between?(1,10)
  #     read_summary
  #   else
  #     invalid
  #     sum_one_or_all
  #   end
  # end

  def read_summary
    index = @input.to_i - 1
    puts "\n"
    puts Article.all[index].title 
    puts Article.all[index].author
    puts "Published: " + Article.all[index].time
    puts Article.all[index].summary
    from_summary
  end 

  # def read_article
  #   index = @input.to_i - 1
  #   article = Article.all[index]
  #   article.format_body
  #   list_or_exit
  # end

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

  def list_or_exit
    puts "\n"
    puts "Enter 'list' to display the list of articles again."
    puts "Type 'exit' to exit the program."
    answer = gets.strip
    if answer == "list"
      run_nyr
    elsif answer != "exit"
      invalid
      list_or_exit
    end
  end

  # def read_or_exit
  #   puts "\n"
  #   puts "Enter the number of an article to read it."
  #   puts "Type 'exit' to exit the program."
  #   @input = gets.strip
  #   if @input.to_i.between?(1,10)
  #     read_or_launch
  #   elsif @input != "exit"
  #     invalid
  #     read_or_exit
  #   end
  # end

  def from_summary
    puts "\n"
    puts "If you would like to read this article, enter 'r'."
    puts "If you would like to launch this article in your browser, enter 'l'."
    puts "To display summaries of all articles, enter 'all'."

    answer = gets.strip
    if answer == "r"
      read_article
    elsif answer == "l"
      launch_article
    elsif answer == "all"
      
    else
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