# frozen_string_literal: true

require_relative "solution"

class Day3 < Solution
  FILE_CONTENT = File.read("./input/day3-input.txt")

  def self.title = "Day 3: Mull It Over"

  def self.description = <<~MSG
    The input is "corrupted memory" that has valid and invalid multiplication instructions,
    where the correct form is mul(x,y) with x and y being 1-3 digit integers. Part 1 is to capture all of
    the valid instructions and find the total sum of the resulting products which come from executing each instruction.
    Part 2 is same idea but abiding by preceding do() and don't() instructions where the default is to do.
  MSG

  def self.solve
    regex = /mul\(\d{1,3},\d{1,3}\)/
    capture_regex = /mul\((\d{1,3}),(\d{1,3})\)/
    valid_operations = []
    sum = 0

    FILE_CONTENT.split("\n").each do |line|
      valid_operations.append(*line.scan(regex))
    end

    valid_operations.each do |operation|
      num1, num2 = *operation.match(capture_regex).captures
      sum += num1.to_i * num2.to_i
    end

    puts sum
  end

  def self.solve2
    sum = 0

    puts sum
  end
end