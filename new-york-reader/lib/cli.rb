require_relative '../config/environment'

class Cli

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

    progress = ProgressBar.create(:format => "%p%% %b",:progress_mark  => ".",:remainder_mark => "\u{FF65}",:starting_at => 0)
    100.times { progress.increment; sleep 0.01 }

    puts "\n"
    Article.all.each_with_index do |article, i|
      puts "#{i + 1}. #{article.title}"
    end
  end

  def menu
    puts "\n"
    puts "- Menu -"
    summary_prompt
    read_prompt
    launch_prompt
    hear_prompt
    list_prompt
    exit_prompt
    gets.strip
  end

  def choose_article
    puts "\n"
    puts "Please enter an article number."
    gets.strip
  end

  def choose_menu_option
    @input = choose_article
    until @input.to_i.between?(1,10)
      invalid
      @input = choose_article #remember that you have to record the user input
    end
    choice = menu
    if choice == "s"
      read_summary
    elsif choice == "r"
      read_article
    elsif choice == "l"
      launch_article
    elsif choice == "h"
      hear_article
    elsif choice == "list"
      run_nyr
    elsif choice != "exit"
      invalid
      choose_menu_option
    end
  end

  def hear_prompt
    puts "Enter 'h' to hear this article in a soothing voice."
  end

  def summary_prompt
    puts "Enter 's' to see a summary of this article."
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
    puts "Enter 'list' to choose a different article from the list."
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
    hear_prompt
    list_prompt
    exit_prompt
    answer = gets.strip
    if answer == "r"
      read_article
    elsif answer == "l"
      launch_article
    elsif answer == "h"
      hear_article
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
    format_body(article)
    from_read
  end

  def from_read
    puts "\n"
    launch_prompt
    hear_prompt
    list_prompt
    exit_prompt
    answer = gets.strip
    if answer == "l"
      launch_article
    elsif answer == "h"
      hear_article
    elsif answer == "list"
      run_nyr
    elsif answer != "exit"
      invalid
      from_read
    end
  end

  def launch_article
    index = @input.to_i - 1
    article = Article.all[index]
    Launchy.open(article.article_url)
    from_launch
  end

  def from_launch
    puts "\n"
    run_nyr
  end

  def hear_article
    index = @input.to_i - 1
    article = Article.all[index]
    full_article = article.title + article.author + article.body.join
    system "say -r 160 -v Alex -o /tmp/temp.aac \"#{full_article}\" "
    system "open /tmp/temp.aac"
    from_hear
  end

  def from_hear
    puts "\n"
    run_nyr
  end

  def run_nyr
    numbered_list
    choose_menu_option
  end

  def invalid
    puts "\n"
    puts "Enter a valid command."
  end

  def format_body(article)
    puts "\n"
    puts article.title
    puts article.author
    puts article.time
    article.body.each do |p|
      puts "\n"
      puts p
    end
    puts "\n"
    puts "- End -"
  end

end
