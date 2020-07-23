require './spec/test_helper'
require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe 'Iteration 1' do
  before :each do
    @book = Book.new({
      author_first_name: "Harper",
      author_last_name: "Lee",
      title: "To Kill a Mockingbird",
      publication_date: "July 11, 1960"
    })
  end

  it '1. Book Instantiation' do
    expect(Book).to respond_to(:new).with(1).argument
    expect(@book).to be_an_instance_of(Book)
  end

  it '2. Book #title' do
    expect(@book).to respond_to(:title).with(0).argument
    expect(@book.title).to eq('To Kill a Mockingbird')
  end

  it '3. Book #author' do
    expect(@book).to respond_to(:author).with(0).argument
    expect(@book.author).to eq('Harper Lee')
  end

  it '4. Book #publication_year' do
    expect(@book).to respond_to(:publication_year).with(0).argument
    expect(@book.publication_year).to eq('1960')
  end
end

RSpec.describe 'Iteration 2' do
  before :each do
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
  end

  it '1. Author Instantiation' do
    expect(Author).to respond_to(:new).with(1).argument
    expect(@charlotte_bronte).to be_an_instance_of(Author)
  end

  it '2. Author #name' do
    expect(@charlotte_bronte).to respond_to(:name).with(0).argument
    expect(@charlotte_bronte.name).to eq('Charlotte Bronte')
  end

  it '3. Author #books' do
    expect(@charlotte_bronte).to respond_to(:books).with(0).argument
    expect(@charlotte_bronte.books).to eq([])
  end

  it '4. Author #write' do
    expect(@charlotte_bronte).to respond_to(:write).with(2).argument
    jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    expect(jane_eyre).to be_an_instance_of(Book)
    expect(jane_eyre.title).to eq('Jane Eyre')
    expect(jane_eyre.publication_year).to eq('1847')
    expect(@charlotte_bronte.books).to eq([jane_eyre])
    villette = @charlotte_bronte.write("Villette", "1853")
    expect(villette.title).to eq('Villette')
    expect(villette.publication_year).to eq('1853')
    expect(@charlotte_bronte.books).to eq([jane_eyre, villette])
  end
end

RSpec.describe 'Iteration 3' do
  before :each do
    @dpl = Library.new("Denver Public Library")
  end

  it '1. Library Instantiation' do
    expect(Library).to respond_to(:new).with(1).argument
    expect(@dpl).to be_an_instance_of(Library)
  end

  it '2. Library #name' do
    expect(@dpl).to respond_to(:name).with(0).argument
    expect(@dpl.name).to eq('Denver Public Library')
  end

  it '3. Library #books' do
    expect(@dpl).to respond_to(:books).with(0).argument
    expect(@dpl.books).to eq([])
  end

  it '4. Library #authors' do
    expect(@dpl).to respond_to(:authors).with(0).argument
    expect(@dpl.authors).to eq([])
  end

  it '5. Library #add_author' do
    expect(@dpl).to respond_to(:add_author).with(1).argument
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    @dpl.add_author(charlotte_bronte)
    @dpl.add_author(harper_lee)

    expect(@dpl.authors).to eq([charlotte_bronte, harper_lee])
    expect(@dpl.books).to eq([jane_eyre, professor, villette, mockingbird])
  end

  it '6. Library #publication_time_frame_for' do
    expect(@dpl).to respond_to(:publication_time_frame_for).with(1).argument
    charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    professor = charlotte_bronte.write("The Professor", "1857")
    villette = charlotte_bronte.write("Villette", "1853")
    mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

    expect(@dpl.publication_time_frame_for(charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
    expect(@dpl.publication_time_frame_for(harper_lee)).to eq({:start=>"1960", :end=>"1960"})
  end
end

RSpec.describe 'Iteration 4' do
  before :each do
    @dpl = Library.new("Denver Public Library")
    @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
    @villette = @charlotte_bronte.write("Villette", "1853")
    @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
    @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
  end

  it '1. Library #checked_out_books' do
    expect(@dpl).to respond_to(:checked_out_books).with(0).argument
    expect(@dpl.checked_out_books).to eq([])
  end

  it '2. Library #checkout' do
    expect(@dpl).to respond_to(:checkout).with(1).argument

    expect(@dpl.checkout(@mockingbird)).to eq(false)
    expect(@dpl.checkout(@jane_eyre)).to eq(false)

    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    expect(@dpl.checkout(@jane_eyre)).to eq(true)
    expect(@dpl.checkout(@villette)).to eq(true)
    expect(@dpl.checked_out_books).to eq([@jane_eyre, @villette])

    expect(@dpl.checkout(@jane_eyre)).to eq(false)
  end

  it '3. Library #return' do
    expect(@dpl).to respond_to(:return).with(1).argument

    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)

    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@villette)
    @dpl.checkout(@mockingbird)

    @dpl.return(@villette)

    expect(@dpl.checked_out_books).to eq([@jane_eyre, @mockingbird])
  end

  it '4. Library #most_popular_book' do
    expect(@dpl).to respond_to(:most_popular_book).with(0).argument

    @dpl.add_author(@charlotte_bronte)
    @dpl.add_author(@harper_lee)
    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@jane_eyre)
    @dpl.return(@jane_eyre)
    @dpl.checkout(@jane_eyre)
    @dpl.checkout(@mockingbird)
    @dpl.return(@mockingbird)
    @dpl.checkout(@mockingbird)
    @dpl.return(@mockingbird)
    @dpl.checkout(@mockingbird)
    @dpl.checkout(@villette)

    expect(@dpl.most_popular_book).to eq(@mockingbird)
  end
end
