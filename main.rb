require_relative "solutions"

solution_class_name = "Day#{ARGV[0]&.to_i || 1}"
solution = Object.const_get(solution_class_name)

puts "---------------------------"
puts solution.title
puts "---------------------------"

puts solution.description
puts "---------------------------"

puts "Solution for part 1 is:"
solution.solve
puts "---------------------------"

puts "Solution for part 2 is:"
solution.solve2
puts "---------------------------"