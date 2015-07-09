# library class
class Library
  def initialize
    $shelf_iterator = 0 # to keep track of number of shelves
    $shelf_array = [] # to store shelf info for access by the library
  end

  def num_shelves
    $shelf_iterator
  end

  def list_books
    $shelf_array.each do |x|
      puts '---'
      puts "'#{x[0]}' written by #{x[1]} is stored on shelf ##{x[3]} in slot #{x[4]}."
      if x[2]
        puts 'This book is checked in.'
      else
        puts 'This book is checked out.'
      end
    end
  end

  def check_out(book)
    title_counter = 0 # allows return of error if book does not exist

    $shelf_array.each do |i|
      if book.title == i[0] && i[2] == true
        i[2] = false
        puts "You checked out '#{book.title}'."
        break
      elsif book.title == i[0] && i[2] == false
        puts "'#{book.title}' is already checked out."
        break
      else
        title_counter += 1
      end
    end
    book_error = "'#{book.title}' has not been added to the library."
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
      a: 'empty',
      b: 'empty',
      c: 'empty',
      d: 'empty',
      e: 'empty'
    }
  end

  # search for an empty slot in the shelf, then assign the book info as array
  def add_to_shelf(book, check_status = true)
    @shelf_hash.each do |key, value|
      if value != 'empty' && key == :e
        puts "Error, this shelf is full! '#{book.title}' NOT added to shelf ##{@shelf_number}."
        break
      elsif value != 'empty'
        next
      elsif value == 'empty'
        @shelf_hash[key] = [book.title, book.author, check_status, @shelf_number, key]
        $shelf_array << @shelf_hash[key]
        puts "'#{book.title}' was added to shelf ##{@shelf_number} in slot #{key}."
        break
      end
    end
  end
end

downtown_library = Library.new

book1 = Book.new('The Bible', 'Jesus')
book2 = Book.new('Moby Dick', 'Herman Melville')
book3 = Book.new('War and Peace', 'Leo Tolstoy')
book4 = Book.new('Learn to Program', 'Chris Pine')
book5 = Book.new('Of Mice and Men', 'John Steinbeck')
book6 = Book.new('1984', 'George Orwell')

shelf1 = Shelf.new
shelf2 = Shelf.new

###############################################################################
# Test section below ### Un-comment a section to test different functionality

# # Add books to a shelf and display a list of the books and their information
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.list_books

# # Add too many books to one shelf and return the error message
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf1.add_to_shelf(book4)
# shelf1.add_to_shelf(book5)
# shelf1.add_to_shelf(book6)

# # Add books to a shelf and check 2 out, display a list of the books
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.check_out(book3)
# downtown_library.check_out(book5)
# downtown_library.list_books

# # Add books to a shelf and try checking out a book already out
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.check_out(book3)
# downtown_library.check_out(book3)

# # Add book to a shelf, check it out, display list, then check in, list
# shelf1.add_to_shelf(book1)
# downtown_library.check_out(book1)
# downtown_library.list_books
# downtown_library.check_in(book1)
# downtown_library.list_books

# # Add book to a shelf, check it out, check it in and try check in again
# shelf1.add_to_shelf(book1)
# downtown_library.check_out(book1)
# downtown_library.list_books
# downtown_library.check_in(book1)
# downtown_library.list_books
# downtown_library.check_in(book1)

# # Try to check out a book that hasn't been added to a shelf
# book7 = Book.new("The Catcher in the Rye", "J.D. Salinger")
# shelf1.add_to_shelf(book1)
# shelf2.add_to_shelf(book2)
# downtown_library.check_out(book7)




