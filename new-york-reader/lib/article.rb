require_relative "../lib/scraper.rb"

class Article

  def initialize(article_url)
    article = Scraper.scrape_article(article_url)
    puts "\n"
    puts article[:title]
    puts "By " + article[:author]
    puts "\n"
    puts "Published at " + article[:time] + " on " + article[:date]
    puts formatted_body(article)
    puts "\n"
  end

  def formatted_body(article)
    article[:body].each do |paragraph|
      puts "\n"
      puts paragraph.text
    end
    puts "\n" + "-end-"
  end

  def prompt
    puts "\n"
    puts "Enter 'back' to return to the list of articles, or 'exit' to exit the program:"
    answer = gets.strip
    # new methods for if/else?
    # if answer ==
  end

end

