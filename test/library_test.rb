require 'minitest/autorun'
require 'minitest/pride'
require './lib/book'
require './lib/author'
require './lib/library'

class LibraryTest < Minitest::Test

  def test_it_exists_with_attributes
    dpl = Library.new("Denver Public Library")
    assert_instance_of Library, dpl
    assert_equal "Denver Public Library", dpl.name
    assert_equal [], dpl.authors
    assert_equal [], dpl.books
  end

  def test_it_can_add_authors_and_books
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

  def test_it_can_give_publication_time_frame
    dpl = Library.new("Denver Public Library")
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    dpl.add_author(charlotte_bronte)
    dpl.add_author(harper_lee)
    time_frame = {:start=>"1847", :end=>"1857"}
    assert_equal time_frame, dpl.publication_time_frame_for(charlotte_bronte)
    time_frame = {:start=>"1960", :end=>"1960"}
    assert_equal time_frame, dpl.publication_time_frame_for(harper_lee)
  end

end
