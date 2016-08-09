class Article
  attr_accessor :title, :author, :body, :time, :summary, :article_url

  @@all = []

  def initialize(article_hash)
    article_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  
  end

  def self.create_from_collection(article_array)
    article_array.each do |article_hash|
      Article.new(article_hash)
    end
  end

  def self.all
    @@all
  end

  def format_body
    puts "\n"
    puts self.title
    puts self.author
    puts self.time
    self.body.each do |p|
      binding.pry
      puts "\n"
      puts p
    end
    puts "\n"
    puts "-End-"
  end

end