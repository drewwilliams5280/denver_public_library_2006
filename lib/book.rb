class Book
  attr_reader :title,
              :times_checked_out


  def initialize(attributes)
    @author_first_name = attributes[:author_first_name]
    @author_last_name = attributes[:author_last_name]
    @title = attributes[:title]
    @publication_date = attributes[:publication_date]
    @times_checked_out = 0
  end

  def author
    "#{@author_first_name} #{@author_last_name}"
  end

  def publication_year
    @publication_date[-4..-1]
  end

  def checkout
    @times_checked_out += 1
  end
end
