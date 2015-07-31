class Book
  attr_accessor :title, :author, :checkStatus

  def initialize(title, author, checkStatus = true)
    @title = title
    @author = author
    @checkStatus = checkStatus
  end
end


class Shelf
  @@shelf_total = 0

  attr_reader :shelf_array

  def initialize
    @@shelf_total += 1
    @shelf_num = @@shelf_total
    @shelf_array = []
  end

  def addToShelf(book)
    if shelf_array.length < 6
      shelf_array << book
      puts "#{book.title} was added to shelf ##{@shelf_num}."
    else
      puts "Can't add #{book.title} to shelf #{@shelf_num}, it's full."
    end
  end
end

class Library

  def initialize
    @stacks = []
  end
end

book1 = Book.new('The Bible', 'Jesus')
book2 = Book.new('Moby Dick', 'Herman Melville')
book3 = Book.new('War and Peace', 'Leo Tolstoy')
book4 = Book.new('Learn to Program', 'Chris Pine')
book5 = Book.new('Of Mice and Men', 'John Steinbeck')
book6 = Book.new('1984', 'George Orwell')

shelf1 = Shelf.new

shelf1.addToShelf(book1)
shelf1.addToShelf(book2)
shelf1.addToShelf(book3)
shelf1.addToShelf(book4)
shelf1.addToShelf(book5)
shelf1.addToShelf(book6)

puts "#{book1.title}, #{book1.author}"








