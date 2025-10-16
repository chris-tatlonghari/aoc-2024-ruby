# frozen_string_literal: true

require_relative "solution"


class Day2 < Solution
  FILE_CONTENT = File.read("./solutions/day2-input.txt")
  SAFETY_THRESHOLD = 3

  def self.title = "Day 2: Red-Nosed Reports"

  def self.description = <<~MSG
    Analyze 2D array of nums.
    Part 1 is get number of rows such that they are either strictly
    increasing or strictly decreasing with a difference of at most 3.
    Part 2 is to get the same number of rows but with a tolerance of 
    breaking the rule at most once.
  MSG

  def self.solve
    input_array = []
    num_safe_rows = 0

    FILE_CONTENT.split("\n").each do |line|
      input_array += [line.split(" ").map(&:to_i)]
    end

    input_array.each do |row|
      direction = row[0] < row[1] ? :increasing : :decreasing
      difference_greater_than_threshold = (row[0] - row[1]).abs > SAFETY_THRESHOLD

      next if row[0] == row[1] || difference_greater_than_threshold

      num_safe_rows += 1 if row_is_safe?(row, direction)
    end

    puts num_safe_rows # 463
  end

  def self.solve2
    input_array = []
    num_safe_rows = 0

    FILE_CONTENT.split("\n").each do |line|
      input_array += [line.split(" ").map(&:to_i)]
    end

    input_array.each.with_index do |original_row|
      original_row.each_index do |i|
        row = original_row.reject.with_index { |_, j| j == i }

        direction = row[0] < row[1] ? :increasing : :decreasing
        difference_greater_than_threshold = (row[0] - row[1]).abs > SAFETY_THRESHOLD

        next if row[0] == row[1] || difference_greater_than_threshold

        if row_is_safe?(row, direction)
          num_safe_rows += 1
          break
        end
      end
    end

    puts num_safe_rows # 514
  end

  private

  class << self
    def row_is_safe?(row, direction)
      1.upto(row.length - 2) do |i|
        continues_to_increase = row[i] < row[i + 1] && direction == :increasing
        continues_to_decrease = row[i] > row[i + 1] && direction == :decreasing
        difference_greater_than_threshold = (row[i] - row[i + 1]).abs > SAFETY_THRESHOLD

        return false if !(continues_to_increase || continues_to_decrease) || difference_greater_than_threshold
      end

      true
    end
  end
end