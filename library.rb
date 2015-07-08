# library class
class Library
  def initialize
    $shelf_iterator = 0
    $shelf_array = []
  end

  def num_shelves
    return $shelf_iterator
  end

  def list_books
    $shelf_array.each do |x|
      puts "'#{x[0]}' written by #{x[1]} is stored on shelf ##{x[3]} in slot #{x[4]}."
      if x[2]
        puts "This book is checked in."
      else
        puts "This book is checked out."
      end
      puts '---'
    end
  end
end

# book class
class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end

# shelf class
class Shelf
  attr_accessor :shelf_hash

  def initialize
    $shelf_iterator += 1
    @shelf_number = $shelf_iterator

    # letters equal slots in the shelf, each shelf has space for 5 books
    @shelf_hash = {
      a: "empty",
      b: "empty",
      c: "empty",
      d: "empty",
      e: "empty"
    }
  end

  # search for an empty slot in the shelf, then assign the book info as array
  def add_to_shelf(book, check_in = true)

    @shelf_hash.each do |key, value|
      if value != "empty"
        next
      elsif value == "empty"
        @shelf_hash[key] = [book.title, book.author, check_in, @shelf_number, key]
        $shelf_array << @shelf_hash[key]
        break
      else
        return "Shelf is full!"
      end
    end
  end
end

downtown_library = Library.new

book1 = Book.new("The Bible", "Jesus")
book2 = Book.new("Moby Dick", "Herman Melville")
book3 = Book.new("War and Peace", "Leo Tolstoy")
book4 = Book.new("Learn to Program", "Chris Pine")

shelf1 = Shelf.new
shelf2 = Shelf.new

shelf1.add_to_shelf(book1)
shelf1.add_to_shelf(book2)
shelf2.add_to_shelf(book3)

downtown_library.list_books
