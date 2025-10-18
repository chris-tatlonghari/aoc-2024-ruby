# frozen_string_literal: true

require_relative "solution"

class Day3 < Solution
  FILE_CONTENT = File.read("./input/day3-input.txt")
  VALID_OPERATION_REGEX = /mul\((\d{1,3}),(\d{1,3})\)/

  def self.title = "Day 3: Mull It Over"

  def self.description = <<~MSG
    The input is "corrupted memory" that has valid and invalid multiplication instructions,
    where the correct form is mul(x,y) with x and y being 1-3 digit integers. Part 1 is to capture all of
    the valid instructions and find the total sum of the resulting products which come from executing each instruction.
    Part 2 is same idea but abiding by preceding do() and don't() instructions where the default is to do.
  MSG

  def self.solve
    puts FILE_CONTENT.scan(VALID_OPERATION_REGEX).sum{ |a, b| a.to_i * b.to_i } # 173419328
  end

  def self.solve2
    valid_operations = FILE_CONTENT.gsub(/don't\(\).*?do\(\)/m, '')

    valid_operations = valid_operations.split(/don't\(\)/).first if valid_operations.include?("don't()")

    puts valid_operations.scan(VALID_OPERATION_REGEX).sum { |a, b| a.to_i * b.to_i } # 90669332
  end
end