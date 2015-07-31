##### Book class #####
class Book
  attr_accessor :title, :author, :location, :checkStatus

  def initialize(title, author, location = nil, checkStatus = true)
    @title = title
    @author = author
    @location = location
    @checkStatus = checkStatus
  end
end

##### Shelf class #####
class Shelf
  @@shelf_total = 0

  attr_reader :shelf_array

  def initialize
    @@shelf_total += 1
    @shelf_num = @@shelf_total
    @shelf_array = []
  end

  def addToShelf(book)
    if shelf_array.length < 5
      book.location = @shelf_num
      shelf_array << book
      puts "#{book.title} was added to shelf ##{book.location}."
    else
      puts "*ERROR* Can't add #{book.title} to shelf #{@shelf_num}, it's full."
    end
  end

  def to_s
    @shelf_array.each do |i|
      puts  "-----"
      print "#{i.title} written by #{i.author} "
      puts  "is located on shelf ##{i.location}."
      puts  "This book is checked in." if i.checkStatus
      puts  "This book is checked out." if i.checkStatus == false
      puts  "-----"
    end
  end
end

##### Library class #####
class Library

  def initialize
    @stacks = []
  end

  def addShelfToLibrary(shelf)
    @stacks << shelf
  end

  def list # unable to name this to_s and have it work when calling x.to_s
    @stacks.each do |x|
      x.to_s
    end
  end
end

##### Librarian class #####
class Librarian

  def checkOut(book)
    if book.checkStatus
      book.checkStatus = false
      puts "=> You checked out '#{book.title}'."
    else
      puts "*ERROR* '#{book.title}' is already checked out."
    end
  end

  def checkIn(book)
    if !book.checkStatus
      book.checkStatus = true
      puts "<= You checked in '#{book.title}'."
    else
      puts "*ERROR* '#{book.title}' was not checked out."
    end
  end

  def checked?(book)
    puts "'#{book.title}' is checked in." if book.checkStatus
    puts "'#{book.title}' is checked out." if book.checkStatus == false
  end
end

book1 = Book.new('The Bible', 'Jesus')
book2 = Book.new('Moby Dick', 'Herman Melville')
book3 = Book.new('War and Peace', 'Leo Tolstoy')
book4 = Book.new('Learn to Program', 'Chris Pine')
book5 = Book.new('Of Mice and Men', 'John Steinbeck')
book6 = Book.new('1984', 'George Orwell')

shelf1 = Shelf.new
shelf2 = Shelf.new

my_library = Library.new

my_librarian = Librarian.new

##### Test Cases ############################################
## Un-comment a section to test the listed program feature ##

# # Add books to 2 different shelves, add to library, list all shelves
# my_library.addShelfToLibrary(shelf1)
# my_library.addShelfToLibrary(shelf2)
# shelf1.addToShelf(book1)
# shelf1.addToShelf(book2)
# shelf1.addToShelf(book3)
# shelf2.addToShelf(book4)
# shelf2.addToShelf(book5)
# shelf2.addToShelf(book6)
# my_library.list

# # Get error when trying to add too many books to a shelf
# shelf1.addToShelf(book1)
# shelf1.addToShelf(book2)
# shelf1.addToShelf(book3)
# shelf1.addToShelf(book4)
# shelf1.addToShelf(book5)
# shelf1.addToShelf(book6)

# # Add books to a shelf and library, then check out a book and check status
# # Then check the book back in
# my_library.addShelfToLibrary(shelf1)
# shelf1.addToShelf(book1)
# my_librarian.checkOut(book1)
# my_librarian.checked?(book1)
# my_librarian.checkIn(book1)

# # Add books to a shelf and library, try to check out twice
# my_library.addShelfToLibrary(shelf1)
# shelf1.addToShelf(book1)
# my_librarian.checkOut(book1)
# my_librarian.checkOut(book1)
