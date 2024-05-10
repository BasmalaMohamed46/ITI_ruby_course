class Inventory
    def initialize
        @books = []
    end

    def add_book(title, author, isbn)  
        if title == "" || author == "" || isbn == ""
            puts "Please enter all the fields"
            return
        end
        if isbn.class != String || title.class != String || author.class != String
            puts "Please enter a valid ISBN, Title and Author"
            return
        end
        @books.each do |book|
            if book[:isbn] == isbn
                book[:title] = title
                book[:author] = author
                book[:count] += 1
                rewrite_file()
                return
            end
        end
        @books.push({title: title, author: author, isbn: isbn,count: 1})
        append_file({title: title, author: author, isbn: isbn,count: 1}) 
    end

    def list_books()
        @books.each do |book|
            puts "Book Title: #{book[:title]} Book Author: #{book[:author]} Book ISBN: #{book[:isbn]} Book Count: #{book[:count]}"
        end
    end
    
    def remove_book(isbn)
        if isbn == ""
            puts "Please enter a valid ISBN"
            return
        end
        if isbn.class != String
            puts "Please enter a valid ISBN"
            return
        end
        @books.delete_if {|book| book[:isbn] == isbn}
        rewrite_file()
    end

    def search_book_isbn(isbn)
        if isbn == ""
            puts "Please enter a valid ISBN"
            return
        end
        if isbn.class != String
            puts "Please enter a valid ISBN"
            return
        end
        @books.each do |book|
            if book[:isbn] == isbn
                puts "Book Title: #{book[:title]} Book Author: #{book[:author]} Book ISBN: #{book[:isbn]} Book Count: #{book[:count]}"
                return
            end
        end
    end

    def search_book_title(title)
        if title == ""
            puts "Please enter a valid Title"
            return
        end
        if title.class != String
            puts "Please enter a valid Title"
            return
        end
        @books.each do |book|
            if book[:title] == title
                puts "Book Title: #{book[:title]} Book Author: #{book[:author]} Book ISBN: #{book[:isbn]} Book Count: #{book[:count]}"
            end
        end
    end

    def search_book_author(author)
        if author == ""
            puts "Please enter a valid Author"
            return
        end
        if author.class != String
            puts "Please enter a valid Author"
            return
        end
        @books.each do |book|
            if book[:author] == author
                puts "Book Title: #{book[:title]} Book Author: #{book[:author]} Book ISBN: #{book[:isbn]} Book Count: #{book[:count]}"
            end
        end
    end

    def sort_books()
        @books=@books.sort_by { |book| book[:isbn]}
        rewrite_file()
    end

    def rewrite_file()
        open('Inventory.txt', 'w') { |f|
        @books.each do |book|
            f.puts "{title: #{book[:title]}, author: #{book[:author]}, isbn: #{book[:isbn]}, Count: #{book[:count]}}" 
        end
        }
    end

    def append_file(book)
        open('Inventory.txt', 'a') { |f|
        f.puts "{title: #{book[:title]}, author: #{book[:author]}, isbn: #{book[:isbn]}, Count: #{book[:count]}}"
    }
    end
end 
obj_inventory = Inventory.new
obj_inventory.add_book("book1" ,"author1", "789")
obj_inventory.add_book("book2", "author2", "456")
obj_inventory.add_book("book3", "author3", "123")
obj_inventory.add_book("book1", "newauthor", "123")

flag = true
while flag
    puts "1. List books"
    puts "2. Add new book"
    puts "3. Remove book by ISBN"
    puts "4. Search book"
    puts "5. Sort books"
    puts "6. Exit"

    choice = gets.chomp
    case choice
    when "1"
        obj_inventory.list_books()
    when "2"
        puts "Enter book title"
        title = gets
        puts "Enter book author"
        author = gets
        puts "Enter book ISBN"
        isbn = gets
        obj_inventory.add_book(title, author, isbn)
    when "3"
        puts "Enter book ISBN"
        isbn = gets
        obj_inventory.remove_book(isbn)
    when "4"
        puts "1. Search by ISBN"
        puts "2. Search by Title"
        puts "3. Search by Author"
        search_choice = gets.chomp
        case search_choice
        when "1"
            puts "Enter book ISBN"
            isbn = gets.chomp
            obj_inventory.search_book_isbn(isbn)
        when "2"
            puts "Enter book Title"
            title = gets.chomp
            obj_inventory.search_book_title(title)
        when "3"
            puts "Enter book Author"
            author = gets.chomp
            obj_inventory.search_book_author(author)
        end
    when "5"
        obj_inventory.sort_books()
    when "6"
        flag = false
    end
end








