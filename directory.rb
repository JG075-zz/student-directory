
@students = [] # an empty array accessible to all methods

def load_program
  try_load_students
  interactive_menu
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def print_menu
  menu = ["Input the students", "Show the students", "Save the list to file", "Load the list from file", "Exit"]
  menu.each_with_index { |option, i|
    puts "#{i+1}. #{option}"
  }
end

def print_feedback(message)
  puts "\n#{message} complete" + "\n "
end

def ask_for_file
  print "\nPlease enter the filename: "
  filename = gets.chomp
  if filename.empty?
    puts "Please enter a filename and try again"
    exit
  end
  return filename
end

def save_students
  # open the file for writing
  File.open(ask_for_file, "w") do |file|
    # iterate over the array of students
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      file.puts student_data.join(",")
    end
  end
  print_feedback("Save the list to file")
end

def load_students(filename = "students.csv")
  puts filename
  if !File.exists?(filename)
    puts "\nSorry, #{filename} doesn't exist."
    exit
  end
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      push_to_student_list(name, cohort.to_sym)
    end
  end
  print_feedback("Load the list from file")
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "\nLoaded #{@students.count} from #{filename}" + "\n "
  else # if it doesn't exist
    puts "\nSorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

def push_to_student_list (name, cohort = :november)
  @students << {name: name, cohort: cohort}
end

def show_students
  print_header
  print_student_list
  print_footer
  print_feedback("Show the students")
end

def process(selection)
  case selection
  when "1" then input_students
  when "2" then show_students
  when "3" then save_students
  when "4" then load_students(ask_for_file)
  when "5" then
    print_feedback("Exiting program...")
    exit
  else puts "\nI don't know what you mean, try again" + "\n "
  end
end

def input_students
  puts "\nPlease enter the names of the students \n" + "To finish, just hit return twice" + "\n "
  # get the first name
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    push_to_student_list(name)
    puts "\nNow we have #{@students.count} students"
    # get another name from the user
    name = STDIN.gets.chomp
  end
  puts "\nInput the students complete" + "\n "
end

def print_header
  puts "\nThe students of Villains Academy \n" + "-------------"
end

def print_student_list
  @students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer
 puts " \nOverall, we have #{@students.count} great students"
end

load_program
