require './lib/book'

class Author
  attr_reader :books

  def initialize(attributes)
    @first_name = attributes[:first_name]
    @last_name = attributes[:last_name]
    @books = []
  end

  def name
    "#{@first_name} #{@last_name}"
  end

  def write(title, publication_date)
    attributes = {
      title: title,
      author_first_name: @first_name,
      author_last_name: @last_name,
      publication_date: publication_date
    }
    book = Book.new(attributes)
    @books << book
    return book
  end

  def range_of_publication
    sorted_books = @books.sort_by do |book|
      book.publication_year.to_i
    end

    years = sorted_books.map { |book| book.publication_year }

    {start: years.first, end: years.last}
  end
end
