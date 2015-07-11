# library class
class Library
  def initialize
    @@shelf_array = [] # to store shelf info for access by the library
  end

  def Library::shelf_array
    @@shelf_array
  end

  def Library::shelf_array=(value)
    @@shelf_array = value
  end

  def num_shelves
    puts Shelf::shelf_iterator
  end

  def list_books
    @@shelf_array.each do |x|
      puts '---'
      puts "'#{x[0]}' written by #{x[1]} is stored on shelf ##{x[3]} in slot #{x[4]}. It's Book ID is #{x[5]}."
      if x[2]
        puts 'This book is checked in.'
      else
        puts 'This book is checked out.'
      end
    end
  end

  def list_books_alpha
    @@shelf_array.sort.each do |x|
      puts '---'
      puts "'#{x[0]}' written by #{x[1]} is stored on shelf ##{x[3]} in slot #{x[4]}. It's Book ID is #{x[5]}."
      if x[2]
        puts 'This book is checked in.'
      else
        puts 'This book is checked out.'
      end
    end
  end

  def check_out(book)
    title_counter = 0 # allows return of error if book does not exist

    @@shelf_array.each do |i|
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
    puts book_error if title_counter == @@shelf_array.length
  end

  def check_in(book)
    @@shelf_array.each do |i|
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

  def list_shelf(shelf_num) # Trying to come up with a way to give error
    puts "The following books are located on shelf ##{shelf_num}:\n---"

    @@shelf_array.each do |s|
      if shelf_num == s[3]
        print "'#{s[0]}' is in slot #{s[4]}. "
        puts "It's Book ID is #{s[5]}"
      end
    end
  end

  def list_commands
    puts "--- Library: Available user commands ---".center(70)
    print "List available user commands:".ljust(30)
    puts "downtown_library.list_commands".rjust(40)
    print "List all books on all shelves:".ljust(30)
    puts "downtown_library.list_books".rjust(40)
    print "List all books alphabetically:".ljust(30)
    puts "downtown_library.list_books_alpha".rjust(40)
    print "List total number of shelves:".ljust(30)
    puts "downtown_library.num_shelves".rjust(40)
    print "List specific shelf:".ljust(30)
    puts "downtown_library.list([shelf number])".rjust(40)
    print "Check out a book:".ljust(30)
    puts "downtown_library.check_out([book ID])".rjust(40)
    print "Check in a book:".ljust(30)
    puts "downtown_library.check_in([book ID])".rjust(40)
    puts "--- End ---".center(70)
  end
end

# book class
class Book
  attr_reader :title, :author, :bookId

  def initialize(title, author, bookId)
    @title = title
    @author = author
    @bookId = bookId
  end
end

# shelf class
class Shelf
  attr_accessor :shelf_hash
  @@shelf_iterator = 0 # to keep track of number of shelves

  def initialize()
    @@shelf_iterator += 1
    @shelf_number = @@shelf_iterator

    # letters equal slots in the shelf, each shelf has space for 5 books
    @shelf_hash = {
      a: 'empty',
      b: 'empty',
      c: 'empty',
      d: 'empty',
      e: 'empty'
    }
  end

  def Shelf::shelf_iterator
    @@shelf_iterator
  end

  def Shelf::shelf_iterator=(value)
    @@shelf_iterator = value
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
        @shelf_hash[key] = [book.title, book.author, check_status, @shelf_number, key, book.bookId]
        Library::shelf_array << @shelf_hash[key]
        puts "'#{book.title}' was added to shelf ##{@shelf_number} in slot #{key}."
        break
      end
    end
  end
end

downtown_library = Library.new

book1 = Book.new('The Bible', 'Jesus', 'book1')
book2 = Book.new('Moby Dick', 'Herman Melville', 'book2')
book3 = Book.new('War and Peace', 'Leo Tolstoy', 'book3')
book4 = Book.new('Learn to Program', 'Chris Pine', 'book4')
book5 = Book.new('Of Mice and Men', 'John Steinbeck', 'book5')
book6 = Book.new('1984', 'George Orwell', 'book6')

shelf1 = Shelf.new
shelf2 = Shelf.new

downtown_library.list_commands

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

# # Add books, then list all books on a specific shelf
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.list_shelf(1)
# downtown_library.list_shelf(2)

# # Attempt to list a shelf that doesn't exist
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.list_shelf(3)

# # Add boks, then list them in alphabetical order
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.list_books_alpha
