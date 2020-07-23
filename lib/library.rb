class Library

  attr_reader :name,
              :books,
              :authors,
              :checked_out_books

  def initialize(name)
    @name = name
    @books = []
    @authors = []
    @checked_out_books = []
  end

  def add_author(author)
    author.books.each do |book|
      @books << book
    end
    @authors << author
  end

  def return(book)
    @books << @checked_out_books.delete(book)
  end

  def publication_time_frame_for(author)
    author.range_of_publication
  end

  def checkout(book)
    if @books.include?(book)
      book.checkout
      @checked_out_books << @books.delete(book)
      true
    else
      false
    end
  end

  def most_popular_book
    checked_out = checked_out_books.max_by {|book| book.times_checked_out}
    in_library = books.max_by {|book| book.times_checked_out}
    return checked_out if in_library.nil?
    return in_library if checked_out.nil?
    [checked_out, in_library].max_by {|book| book.times_checked_out}
  end
end
