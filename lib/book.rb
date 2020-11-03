class Book
  attr_accessor :book_title, :book_author, :book_published, :book_age, :book_description

  @@all = []

  def initialize(book_hash)
    book_hash.each do |key, value|
      send("#{key}=", value)
      @@all << self
    end
   end

  def self.create_from_list(book_array)
    book_array.each do |book_hash|
      Book.new(book_hash)
    end
   end

  def self.all
    @@all.uniq
  end
end
