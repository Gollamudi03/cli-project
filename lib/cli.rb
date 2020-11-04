class CLI
  page_url = 'https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die'
  
  def make_book_list(page_url = "https://www.goodreads.com/shelf/show/100-books-to-read-before-you-die")
    book_array = Scraper.scrape_page(page_url)
    Book.create_from_list(book_array)
    Book.all[0..24].each_with_index do |book, index|
      puts "#{index + 1}. #{book.book_title} by #{book.book_author} written in #{book.book_published}"
    end
    input = ''
    while input != 'no'
      puts 'Would you like to print the remainder of the list? (type "yes/no")'
      input = gets.chomp.downcase
      if input == 'yes'
           Book.all[25..-1].each_with_index do |book, index|
             puts "#{index + 26}. #{book.book_title} by #{book.book_author} written in #{book.book_published}"
           end
           break
      end

    end
  end

  def set_book_age
    if Book.all.empty?
      try_again
    else
      Book.all.each do |book|
        book.book_age = Time.now.year - book.book_published.to_i
        puts "#{book.book_title} is #{book.book_age} years old!"
      end
    end
  end

  def get_book_description
    if Book.all.empty?
      puts "Please generate the list first and then try again!"
    else
      puts "Please enter a number from the list in order to view more details about the book:"
      selection = gets.to_i
      if selection.between?(1, 50)
        puts "Here's a brief description of #{Book.all[selection - 1].book_title}"
        puts "#{Book.all[selection - 1].book_description}"
      else
        puts "Number is out of range! Please try again!"
      end
    end
  end

  def try_again
    puts 'There are no books to shuffle! Please try creating a list first and then try again!'
  end

  def goodbye
    puts   "THANK YOU"
  end

  def call
    user_input = ''

    while user_input != 'exit'
      puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'
      puts '   '
      puts 'THE BEST BOOKS TO READ'
      puts ' '
      puts 'FIND BOOKS TO READ'
      puts '^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ ^ '
      puts "  "
      puts 'Please enter and get the details about the books'
      puts ' '
      puts "=> Enter 'list' to get the list of books."
      puts "=> Enter 'description' to get the description of a book. "
      puts "=> Enter 'year' to calculate the age of the books"
      puts "=> Enter 'exit' to exit this program."
      puts "  "
      puts '* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *'

      user_input = gets.chomp.downcase

      case user_input
      when 'list'
        puts "Please Wait... This might take a minute..."
        puts"loading......"
        make_book_list
      when 'description'
        get_book_description
      when 'year'
        set_book_age
      when 'sort'
        sort_by_age
      when 'exit'
        goodbye
       else
       	puts "Invalid selection! Please try again!"
      end
    end
  end
end
