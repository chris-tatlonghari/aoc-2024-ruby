# frozen_string_literal: true

require_relative "solution"

class Day1 < Solution
  FILE_CONTENT = File.read("./input/day1-input.txt")

  def self.title = "Day 1: Historian Hysteria"

  def self.description = <<~MSG
    Compare two lists.
    Problem 1 is to compare absolute difference of the numbers
    in each list in sorted order.
    Problem 2 is summing the product of numbers in the first list with
    their number of occurences in the second.
  MSG
  
  def self.solve
    list1, list2 = [], []
    total_distance = 0

    FILE_CONTENT.split("\n").each do |line|
      num1 = line.split(" ").first.to_i
      num2 = line.split(" ").last.to_i

      list1.append num1
      list2.append num2
    end

    list1.sort!
    list2.sort!

    0.upto(list1.length - 1) do |i|
      total_distance += (list1[i] - list2[i]).abs
    end

    puts total_distance # 1722302
  end

  def self.solve2
    list1, list2 = [], {}
    similarity_score = 0

    FILE_CONTENT.split("\n").each do |line|
      num1 = line.split(" ").first.to_i
      num2 = line.split(" ").last.to_i

      list1.append num1
      list2[num2] ||= 0
      list2[num2] += 1 
    end

    0.upto(list1.length - 1) do |i|
      num_occurences = list2.has_key?(list1[i]) ? list2[list1[i]] : 0
      similarity_score += (list1[i] * num_occurences)
    end

    puts similarity_score # 20373490
  end
end