# Final version
# library class.  As-is, will only allow for one instance of library due to
# use of class variables (@@shelf_array).
class Library
  # Initialize a shelf array to store info for access by library methods.
  def initialize
    @@shelf_array = []
  end

  # Create getter/setter for the shelf array class variable.
  def self.shelf_array
    @@shelf_array
  end

  def self.shelf_array=(value)
    @@shelf_array = value
  end

  # Method to return the total number of shelves created.
  def num_shelves
    puts Shelf::shelf_iterator
  end

  # Method to display all the books and their information, check in/out status.
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

  # Method to list all the books in alphabetical order.
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

  # Method to check out a book including returning an error message if the book
  # is already checked out. This changes the check status in the library's
  # shelf_array only, does not change any info in the shelf_hash where the book
  # is stored. At this time not sure if this is good practice or not.
  def check_out(book)
    title_counter = 0

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

  # Method to check in a book, including returning an error if the book is
  # already checked in.
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

  # Method that takes a shelf number and returns all the books from that shelf
  # and their information. Haven't created an error message yet.
  def list_shelf(shelf_num)
    puts "The following books are located on shelf ##{shelf_num}:\n---"

    @@shelf_array.each do |s|
      if shelf_num == s[3]
        print "'#{s[0]}' is in slot #{s[4]}. "
        puts "It's Book ID is #{s[5]}"
      end
    end
  end

  # Method to create a menu of the available command. This is assuming the
  # library name is downtown_library, since at the moment my code allows
  # only one instance of Library to exist without errors.
  def list_commands
    puts '--- Library: Available user commands ---'.center(70)
    print 'List available user commands:'.ljust(30)
    puts 'downtown_library.list_commands'.rjust(40)
    print 'List all books on all shelves:'.ljust(30)
    puts 'downtown_library.list_books'.rjust(40)
    print 'List all books alphabetically:'.ljust(30)
    puts 'downtown_library.list_books_alpha'.rjust(40)
    print 'List total number of shelves:'.ljust(30)
    puts 'downtown_library.num_shelves'.rjust(40)
    print 'List specific shelf:'.ljust(30)
    puts 'downtown_library.list_shelf([shelf number])'.rjust(40)
    print 'Check out a book:'.ljust(30)
    puts 'downtown_library.check_out([book ID])'.rjust(40)
    print 'Check in a book:'.ljust(30)
    puts 'downtown_library.check_in([book ID])'.rjust(40)
    puts '--- End ---'.center(70)
  end
end

# Book class. Added a bookId in order to be able to allow the user to check
# in/out a book from the command line.  The bookId parameter must be entered
# exactly the same as the book's variable name for it to be correct.
class Book
  attr_reader :title, :author, :bookId

  def initialize(title, author, bookId)
    @title = title
    @author = author
    @bookId = bookId
  end
end

# Shelf class. Was hoping to be able to only manipulate each shelf instances'
# shelf_hash from the Library class for check in/out, however ran into the
# issue of not knowing what each shelf's variable name was going to be, so
# not sure how to be able to access an unknown shelf name from the Library.
# Currently the issue preventing multiple libraries to exist at the same time.
# Have some ideas but unable to implement them at this time.
class Shelf
  attr_accessor :shelf_hash
  @@shelf_iterator = 0 # To keep track of total number of shelves created.

  # Iterate the number of shelves, current number gets set as instance shelf #
  def initialize
    @@shelf_iterator += 1
    @shelf_number = @@shelf_iterator

    # Letters equal slots in the shelf, each shelf has space for 5 books.
    @shelf_hash = {
      a: 'empty',
      b: 'empty',
      c: 'empty',
      d: 'empty',
      e: 'empty'
    }
  end

  # Shelf iterator getter
  def self.shelf_iterator
    @@shelf_iterator
  end

  # Search for an empty slot in the shelf, then assign the book info as an
  # array to the empty hash key.  Default check status is true, or
  # 'checked in'. Displays an error if there are no empty slots on the current
  # shelf. The value to the current key (which is an array) is pushed into the
  # shelf_array in the Library class.  As stated before this is my work around
  # to be able to access the information from within the Library class without
  # knowing future shelves variable names.
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

# Create a library instance
downtown_library = Library.new

# Create book instances
book1 = Book.new('The Bible', 'Jesus', 'book1')
book2 = Book.new('Moby Dick', 'Herman Melville', 'book2')
book3 = Book.new('War and Peace', 'Leo Tolstoy', 'book3')
book4 = Book.new('Learn to Program', 'Chris Pine', 'book4')
book5 = Book.new('Of Mice and Men', 'John Steinbeck', 'book5')
book6 = Book.new('1984', 'George Orwell', 'book6')

# Create shelf instances
shelf1 = Shelf.new
shelf2 = Shelf.new

###############################################################################
# Test section below ### Un-comment a section to test different functionality
# Only one section should be un-commented at a time

# Add books to a shelf, display list of books and information - default
shelf1.add_to_shelf(book1)
shelf1.add_to_shelf(book2)
shelf1.add_to_shelf(book3)
shelf2.add_to_shelf(book4)
shelf2.add_to_shelf(book5)
shelf2.add_to_shelf(book6)
downtown_library.list_books
downtown_library.list_commands

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

# # Add books, then list them in alphabetical order
# shelf1.add_to_shelf(book1)
# shelf1.add_to_shelf(book2)
# shelf1.add_to_shelf(book3)
# shelf2.add_to_shelf(book4)
# shelf2.add_to_shelf(book5)
# shelf2.add_to_shelf(book6)
# downtown_library.list_books_alpha
