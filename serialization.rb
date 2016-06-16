require 'csv'
require 'date'

class Person

  attr_reader :id, :first_name, :last_name, :email, :phone, :created_at

  def initialize(components = {})
    @id = components[:id]
    @first_name = components[:first_name]
    @last_name = components[:last_name]
    @email = components[:email]
    @phone = components[:phone]
    @created_at = components[:created_at]
   end 
  # Look at the above CSV file
  # What attributes should a Person object have?
end

class PersonParser
  attr_reader :file, :people
  
  def initialize(file)
    @file = file
    @people = []
  end
  
  def people
    # If we've already parsed the CSV file, don't parse it again.
    # Remember: @people is +nil+ by default.
    return @people if @people
    CSV.foreach(@file, {:headers => true, header_converters: :symbol}) do |row| 
      @people << Person.new(row_to_h)
    # We've never called people before, now parse the CSV file
    # and return an Array of Person objects here.  Save the
    # Array in the @people instance variable.
  end
p @people
 
  def add_person(attributes)
    new_person = Person.new(attributes)
    @people << new_person

  new_person_arr = [new_person.id, new_person.first_name, new_person.last_name, 
  new_person.email, new_person.phone, new_person.created_at]

  CSV.open(@file, "a+") do |csv|
  csv << new_person_arr
  end  
end

parser = PersonParser.new('people.csv')
parser.people
puts "There are #{parser.people.size} people in the file '#{parser.file}'."


1 require 'csv'
2 require 'date'
3 
4 class DateTime
5 
6   attr_reader :string
7 
8   def initialize(string)
9   end
10  
11  end
12  
13  class Person
14  
15    attr_reader :id, :first_name, :last_name, :email, :phone, :created_at
16  
17    def initialize(id, first_name, last_name, email, phone, created_at)
18      @id = id
19      @first_name = first_name
20      @last_name = last_name
21      @email = email
22      @phone = phone
23      @created_at = created_at
24    end
25  
26  end
27  
28  class PersonParser
29  
30    attr_reader :file, :people
31  
32    def initialize(file)
33      @file = file
34      @people = nil
35    end
36  
37    def people
38      return @people if @people
39      @people = []
40  
41      x = 0
42      CSV.foreach(File.path(@file)) do |row|
43        unless x == 0
44            @people << Person.new(row[0], row[1], row[2], row[3], row[4], DateTime.parse(row[5]))
45        end
46        x += 1
47      end
48  
49      return @people
50    end
51  
52    def add_person(new_person)
53       @people << new_person
54    end
55  
56    def save
57  
58      CSV.open(@file, "wb") do |csv|
59        csv << ["id", "first_name","last_name", "email", "phone", "created_at"]
60        @people.each do |person|
61          person_array = []
62          person_array << person.id
63          person_array << person.first_name
64          person_array << person.last_name
65          person_array << person.phone
66          person_array << person.created_at
67          csv << person_array
68        end
69      end
70    end
71  end
72  
73  parser = PersonParser.new('people.csv')
74  
75  
76  puts "There are #{parser.people.size} people in the file '#{parser.file}'."
77  
78  parser.add_person(Person.new(201, "Lydia", "Cheah", "cheahlizuan@gmail.com", "0123456789", Time.now))
79  
80  parser.save
