require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'classroom'
require_relative 'rental'

class App
  def initialize
    @book_shelf = []
    @persons = []
    @rentals = []
  end

  def start_app
    puts 'Welcome to OOP University Library App!'
    until list_of_options
      input = gets.chomp
      if input == '7'
        puts 'Thank you for visiting our University Library!'
        break
      end
      option(input)
    end
  end

  # books
  def create_book
    puts 'Add a new book'
    puts 'Enter title: '
    title = gets.chomp
    puts 'Enter author: '
    author = gets
    book = Book.new(title, author)
    @book_shelf.push(book)
    puts "#{title} has been successfully added to the book shelf."
  end
  
  def list_all_book
    puts 'No book in the libary! Please enter 1 to add a book.' if @book_shelf.empty?
    @book_shelf.each { |book| puts "[Book] Title: #{book.title}, Author: #{book.author}" }
  end
 
  # persons
  def create_person
    puts 'Enter 1 to add a student or 2 to add a teacher or 7 to go back : '
    option = gets.chomp

    case option
    when '1'
      create_student
    when '2'
      create_teacher
    when '7'
        start_app
    else
      puts 'Invalid input!. Try again'
      create_person
    end
  end

  def create_student
    puts 'Add a new student'
    print 'Enter name: '
    name = gets.chomp
    print 'Enter age: '
    age = gets.chomp.to_i
    print 'Has parent permission? [y/n]: '
    parent_permission = gets.chomp.downcase
    until parent_permission == 'n' or parent_permission == 'y' do
        puts 'Enter y for yes and n for no'
        print 'Has parent permission? [y/n]: '
        parent_permission = gets.chomp.downcase
    end
    case parent_permission
    when 'n'
      student = Student.new(age: age, name: name, parent_permission: parent_permission, classroom: @classroom)
      @persons << student
      puts 'Student doesn\'t have parent permission, and can\'t rent book'
    when 'y'
      student = Student.new(age: age, name: name, parent_permission: parent_permission, classroom: @classroom)
      @persons << student
      puts 'Student added successfully'
    end
  end
  
  def create_teacher
    puts 'Add a teacher'
    print 'Enter teacher name: '
    name = gets.chomp
    print 'Enter age: '
    age = gets.chomp.to_i
    print 'Enter specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @persons << teacher
    puts 'Teacher added successfully'
  end

  def list_all_persons
    puts 'No one in the libray list! Add a person.' if @persons.empty?
    @persons.each do |person|
      puts "[#{person.class.name}] Name: #{person.name}, ID: #{person.id},  Age: #{person.age}"
    end
  end

  # rental
  def create_rental
    puts 'Select the book you want to rent by entering its number'
    @book_shelf.each_with_index { |book, index| puts "(#{index}) Title: #{book.title}, Author: #{book.author}" }

    book_id = gets.chomp.to_i
    puts 'Select a person from the list by its number'
    @persons.each_with_index do |person, index|
      puts "(#{index}) [#{person.class.name}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    person_id = gets.chomp.to_i

    puts 'Date: '
    date = gets.chomp.to_s
    rental = Rental.new(date, @persons[person_id], @books[book_id])
    @rentals << rental
    puts 'Rental created successfully'
  end

  def list_all_rentals
    puts 'To see rentals enter the person ID: '
    id = gets.chomp.to_i

    puts 'Rented Books: '
    @rentals.each do |rental|
      if rental.person.id == id
        puts "Person: #{rental.person.name} Date: #{rental.date}, Book: '#{rental.book.title}' by #{rental.book.author}"
      else
        puts 'No match found for the given ID'
      end
    end
  end
end