@students = [] # an empty array accessible to all methods

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_student_list
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  puts "You can also enter their cohort: name (cohort), john (novemeber)"
  # get the first name
  name = gets.delete("\n").split("(")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # check if cohort has been entered
    if name[1] == nil
      cohort = :no
    # if so, set cohort to the one entered, and delte the trailing ")"
    else
      cohort = name[1].delete(")").to_sym
    end
    # remove any trailing white space from name
    name = name[0].rstrip
    puts "Please enter any hobbies they have (else 'none')"
    hobbies = gets.delete("\n")
    puts "Please enter their country of birth"
    country = gets.delete("\n").to_sym
    puts "Please enter their height (in ft)"
    height = gets.delete("\n")
    # add the student hash to the array
    @students << {name: name, hobbies: hobbies, country: country, height: height, cohort: cohort}
    puts "Now we have #{@students.count} students"
    # get another name from the user
    name = gets.delete("\n").split("(")
  end  
end

def print_header
  puts "The students of Villains Academy".center(70)
  puts "-------------".center(70)
end

def print_student_list
  if @students.length >= 1
    cohort_list = []
    # add non-duplicate cohorts to the cohort_list
    @students.each do |student|
      if !cohort_list.include?(student[:cohort])
        cohort_list << student[:cohort]
      end
    end
    # used to number student list
    student_count = 0
    # for each cohort, list all students that belong to that group
    cohort_list.each do |cohort|
      @students.each do |student|
        if student[:cohort] == cohort
          puts "#{student_count+1}. #{student[:name]} (#{student[:cohort]} cohort). Hobbies: #{student[:hobbies]}, Country: #{student[:country]}, Height: #{student[:height]} ft.".center(70)
          student_count += 1
        end
      end
    end
  else
    puts "No students added yet.".center(70)
  end
end

def print_footer
  str = "Overall, we have #{@students.count} great student"
  # omit the "s" on "student" if there is only one student
  str += @students.count == 1 ? "" : "s"
  puts str.center(70)
  puts
end

interactive_menu
