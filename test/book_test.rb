require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'

class BookTest < Minitest::Test

  def test_it_exists_with_attributes
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

    assert_instance_of Book, book
    assert_equal "To Kill a Mockingbird", book.title
  end

  def test_it_can_combine_first_and_last_names
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})

    assert_equal "Harper Lee", book.author
  end

  def test_it_can_find_publication_year
    book = Book.new({author_first_name: "Harper", author_last_name: "Lee", title: "To Kill a Mockingbird", publication_date: "July 11, 1960"})
    assert_equal "1960", book.publication_year
  end
end
