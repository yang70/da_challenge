# book class
class Book
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end
end

# shelf class
class Shelf

  def initialize
    $shelf_number += 1

    # letter is slots in the shelf, each shelf has space for 5 books
    @shelf_hash = {
      a: "empty",
      b: "empty",
      c: "empty",
      d: "empty",
      e: "empty"
    }
  end

  def add_to_shelf(book, check_in = true)
    @shelf_hash.each do |key, value|
      if value != "empty"
        next
      elsif value == "empty"
        @shelf_hash[key] = [book.title, book.author, check_in]
        break
      else
        return "Shelf is full!"
      end
    end
  end

  def return_hash
    @shelf_hash
  end
end

# library class
class Library
  def initialize
    $shelf_number = 0
  end

  def num_shelves
    return $shelf_number
  end

  def list_books

  end
end

downtown_library = Library.new

book1 = Book.new("The Bible", "Jesus")
book2 = Book.new("Moby Dick", "Herman Melville")

new_shelf = Shelf.new
new_shelf2 = Shelf.new

new_shelf.add_to_shelf(book1)
new_shelf.add_to_shelf(book2)

p new_shelf.return_hash[:a]
p new_shelf.return_hash[:b]
p downtown_library.num_shelves
