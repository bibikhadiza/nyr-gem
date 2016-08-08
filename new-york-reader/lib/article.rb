require_relative "../lib/scraper.rb"

class Article

  def initialize(article_url)
    article = Scraper.scrape_article(article_url)
    puts "\n"
    puts article[:title]
    puts "By " + article[:author]
    puts "\n"
    puts "Published: " + article[:time]
    puts formatted_body(article)
    puts "\n"
  end

  def formatted_body(article)
    article[:body].each do |paragraph|
      puts "\n"
      puts paragraph.text
    end
    puts "\n" + "-End-"
  end

end

