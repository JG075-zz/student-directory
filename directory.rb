def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  puts "You can also enter their cohort: name (cohort), john (novemeber)"
  # create an empty array
  students = []
  # get the first name
  name = gets.chomp.split("(")
  # while the name is not empty, repeat this code
  while !name.empty? do
    # check if cohort has been entered
    if name[1] == nil
      cohort = :none
    # if so, set cohort to the one entered, and delte the trailing ")"
    else
      cohort = name[1].delete(")").to_sym
    end
    # remove any trailing white space from name
    name = name[0].rstrip
    puts "Please enter any hobbies they have (else 'none')"
    hobbies = gets.chomp
    puts "Please enter their country of birth"
    country = gets.chomp.to_sym
    puts "Please enter their height (in ft)"
    height = gets.chomp
    # add the student hash to the array
    students << {name: name, hobbies: hobbies, country: country, height: height, cohort: cohort}
    puts "Now we have #{students.count} students"
    # get another name from the user
    name = gets.chomp.split("(")
  end
  # return the array of students
  students
end

def print_header
  puts "The students of Villains Academy".center(70)
  puts "-------------".center(70)
end

def print(students)
   student_count = 0
   until student_count == students.length
       puts "#{student_count+1}. #{students[student_count][:name]} (#{students[student_count][:cohort]}) cohort. Hobbies: #{students[student_count][:hobbies]}, Country: #{students[student_count][:country]}, Height: #{students[student_count][:height]} ft.".center(70)
       student_count += 1
   end
end

def print_footer(students)
  puts "Overall, we have #{students.count} great students".center(70)
end
# nothing happens until we call the methods
students = input_students
print_header
print(students)
print_footer(students)
