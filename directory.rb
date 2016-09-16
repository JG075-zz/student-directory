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
  cohort_list = []
  # add non-duplicate cohorts to the cohort_list
  students.each do |student|
    if !cohort_list.include?(student[:cohort])
      cohort_list << student[:cohort]
    end
  end
  # used to number list
  student_count = 0
  # for each cohort, list all students that belong to that group
  cohort_list.each do |cohort|
    students.each do |student|
      if student[:cohort] == cohort
        puts "#{student_count+1}. #{student[:name]} (#{student[:cohort]}) cohort. Hobbies: #{student[:hobbies]}, Country: #{student[:country]}, Height: #{student[:height]} ft.".center(70)
        student_count += 1()
      end
    end
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
