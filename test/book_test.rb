require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'

class BookTest < Minitest::Test
  def test_it_exists
    book = Book.new({author_first_name: "Harper",
                    author_last_name: "Lee",
                    title: "To Kill a Mockingbird",
                    publication_date: "July 11, 1960"})

    assert_instance_of Book, book
  end

  def test_it_has_a_title
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

    assert_equal "To Kill a Mockingbird", book.title
  end

  def test_it_has_an_author
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

    assert_equal "Harper Lee", book.author
  end

  def test_it_can_get_publication_year
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
    assert_equal "1960", book.publication_year

    book = Book.new({author_first_name: "Charlotte", author_last_name: "Bronte", title: "Villette", publication_date: "1853"})
    assert_equal "1853", book.publication_year
  end
end
