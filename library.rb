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

  def check_out(book)
    title_counter = 0

    $shelf_array.each do |i|
      if book.title == i[0] && i[2] == true
        i[2] = false
        puts "You checked out '#{book.title}'."
        break
      elsif book.title == i[0] && i[2] == false
        puts "#{book.title} is already checked out."
        break
      else
        title_counter +=1
      end
    end
    book_error = "That book is not part of the library"
    puts book_error if title_counter == $shelf_array.length
  end

  def check_in(book)
    $shelf_array.each do |i|
      if book.title == i[0] && i[2] == false
        i[2] = true
        puts "You checked in '#{book.title}'"
        break
      elsif book.title == i[0] && i[2] == true
        puts "'#{book.title}' is already checked in."
        break
      else
        next
      end
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
  def add_to_shelf(book, check_status = true)

    @shelf_hash.each do |key, value|
      if value != "empty" && key == :e
        puts "Error, this shelf is full! '#{book.title}' NOT added to shelf ##{@shelf_number}."
        break
      elsif value != "empty"
        next
      elsif value == "empty"
        @shelf_hash[key] = [book.title, book.author, check_status, @shelf_number, key]
        $shelf_array << @shelf_hash[key]
        puts "'#{book.title}' was added to shelf ##{@shelf_number} in slot #{key}."
        break
      end
    end
  end
end

downtown_library = Library.new

book1 = Book.new("The Bible", "Jesus")
book2 = Book.new("Moby Dick", "Herman Melville")
book3 = Book.new("War and Peace", "Leo Tolstoy")
book4 = Book.new("Learn to Program", "Chris Pine")
book5 = Book.new("Of Mice and Men", "John Steinbeck")
book6 = Book.new("1984", "George Orwell")

shelf1 = Shelf.new
shelf2 = Shelf.new

shelf1.add_to_shelf(book1)
shelf1.add_to_shelf(book2)
shelf1.add_to_shelf(book3)
shelf1.add_to_shelf(book4)
shelf1.add_to_shelf(book5)
shelf1.add_to_shelf(book6)

# downtown_library.list_books

