require 'nokogiri'
require 'open-uri'

BASE_URL = "https://www.goodreads.com/"

class Scraper
  def self.scrape_page(page_url = 'https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die')
    books_array = []

    book_list_page = Nokogiri::HTML(open(page_url))
    book_list_page.css('div.leftContainer').each do |container|
      container.css('div.elementList').each do |element|
        title = element.css('a.leftAlignedImage').attr('title').text
        author = element.css('div.authorName__container a').text
        published = element.css('span.greyText').text.gsub(/\s+/, '')[-4..-1]
        book_description_url = element.css('a.bookTitle').attr('href').value
        book_details_page = Nokogiri::HTML(open(BASE_URL + book_description_url))
        book_description = book_details_page.css('div.last.col div.readable.stacked span').text
        books_array << { book_title: title, book_author: author, book_published: published, book_description: book_description }
      end
    end
    books_array
  end
end