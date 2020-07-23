require './lib/library'
require './lib/author'
require "minitest/autorun"
require "minitest/pride"

class LibraryTest < Minitest::Test
  def test_it_exists
    dpl = Library.new("Denver Public Library")

    assert_instance_of Library, dpl
  end

  def test_attributes
    dpl = Library.new("Denver Public Library")

    assert_equal "Denver Public Library", dpl.name
    assert_equal [], dpl.books
    assert_equal [], dpl.authors
  end

  def test_authors_and_books
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})

    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    professor = charlotte_bronte.write("The Professor", "1857")

    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)

    dpl.add_author(harper_lee)

    assert_equal [charlotte_bronte, harper_lee], dpl.authors
    assert_equal [jane_eyre, professor, villette, mockingbird], dpl.books
  end

  def test_publication_time_frame_for
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})

    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")

    professor = charlotte_bronte.write("The Professor", "1857")

    villette = charlotte_bronte.write("Villette", "1853")

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})

    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    dpl.add_author(charlotte_bronte)

    dpl.add_author(harper_lee)
    expected = {:start=>"1847", :end=>"1857"}
    assert_equal expected, dpl.publication_time_frame_for(charlotte_bronte)
    expected =  {:start=>"1960", :end=>"1960"}
    assert_equal expected, dpl.publication_time_frame_for(harper_lee)

  end

  def test_checkout
    dpl = Library.new("Denver Public Library")

    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    #=> #<Author:0x00007f8c01429a98...>

    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    #=> #<Book:0x00007f8c01433138...>

    villette = charlotte_bronte.write("Villette", "1853")
    #=> #<Book:0x00007f8c021d84c8...>

    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    #=> #<Author:0x00007f8c01442520...>

    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    #=> #<Book:0x00007f8c019506c0...>

    # This book cannot be checked out because it doesn't exist in the library
    assert_equal false, dpl.checkout(mockingbird)

    # This book cannot be checked out because it doesn't exist in the library
    assert_equal false, dpl.checkout(jane_eyre)

    assert_equal [], dpl.checked_out_books

    dpl.add_author(charlotte_bronte)

    dpl.add_author(harper_lee)

    assert_equal true, dpl.checkout(jane_eyre)
    assert_equal [jane_eyre], dpl.checked_out_books

    # # This book cannot be checked out because it is currently checked out
    assert_equal false, dpl.checkout(jane_eyre)
    #
    dpl.return(jane_eyre)
    #
    # # Returning a book means it should no longer be checked out
    assert_equal [], dpl.checked_out_books
    #
    assert_equal true, dpl.checkout(jane_eyre)
    #
    assert_equal true, dpl.checkout(villette)
    #
    # #=> [#<Book:0x00007f8c01433138...>, #<Book:0x00007f8c021d84c8...>]
    assert_equal [jane_eyre, villette], dpl.checked_out_books
    #
    assert_equal true, dpl.checkout(mockingbird)
    #
    dpl.return(mockingbird)
    #
    assert_equal true, dpl.checkout(mockingbird)
    #
    dpl.return(mockingbird)
    #
    assert_equal true, dpl.checkout(mockingbird)

    assert_equal mockingbird, dpl.most_popular_book
    # #=> #<Book:0x00007f8c019506c0...>
  end

end
#
# The `checkout` method takes a `Book` as an argument. It should return `false` if a `Book` does not exist in the library or it is already checked out. Otherwise, it should return true indicating that the book has been checked out.
#
# The `checked_out_books` method should return an array of books that are currently checked out.
#
# The `return` method takes a `Book` as an argument. Calling this method means that a book is no longer checked out.
#
# The `most_popular_book` method should return the book that has been checked out the most.
#

#
#
# dpl.checked_out_books
# #=> [#<Book:0x00007f8c01433138...>]
#
# ```
