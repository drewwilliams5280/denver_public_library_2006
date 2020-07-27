class Library

  attr_reader :name, :authors, :books
  def initialize(name)
    @name = name
    @authors = []
    @books = []
  end

  def add_author(author)
    @authors << author
    author.books.each {|book| @books << book}
  end

  def publication_time_frame_for(author)
    pub_years = author.books.map {|book| book.publication_year}
    {start: pub_years.min, end: pub_years.max}
  end

end
