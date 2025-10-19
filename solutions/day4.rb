# frozen_string_literal: true

require_relative "solution"

class Day4 < Solution
  FILE_CONTENT = File.read("./input/day4-input.txt")
  DIRECTIONS = (-1..1).to_a.product((-1..1).to_a).reject! { |dx, dy| dx == 0 && dy == 0 }
  SEARCH_WORD = "XMAS"
  CENTER_CHAR = 'A'
  OUTER_CHARS = ['M','S'].freeze

  def self.title = "Ceres Search"

  def self.description = <<~MSG
    The input is a nxn matrix of characters in the form of a word search. The first part is to find and return the # occurences of XMAS spelled
    out in any of eight directions. The second part is to find and return the # of occurences two crossed instances of "MAS" spelled out in
    any direction.
  MSG

  def self.solve
    matrix = FILE_CONTENT.lines.map(&:chomp)
    matches = 0

    0.upto(matrix.first.length - 1) do |x0|
      0.upto(matrix.count - 1) do |y0|
        matches += DIRECTIONS.sum do |dx, dy|
          x, y = x0, y0
          word = matrix[x][y]
          count = 0

          while (0...matrix.first.size).cover?(x + dx) && (0...matrix.size).cover?(y + dy)
            x += dx
            y += dy
            word += matrix[x][y]
            count += 1 if word == SEARCH_WORD
          end

          count
        end
      end
    end

    puts matches # 2434
  end

  def self.solve2
    matrix = FILE_CONTENT.lines.map(&:chomp)
    matches = 0

    0.upto(matrix.first.length - 1) do |x0|
      0.upto(matrix.count - 1) do |y0|
        next unless x0 >= 1 && y0 >= 1 && x0 < matrix.first.length - 1 && y0 < matrix.count - 1
        next unless matrix[x0][y0] == CENTER_CHAR
          
        top_left = matrix[x0 - 1][y0 - 1]
        bottom_left = matrix[x0 + 1][y0 - 1]
        top_right = matrix[x0 - 1][y0 + 1]
        bottom_right = matrix[x0 + 1][y0 + 1]

        next unless OUTER_CHARS.include?(top_left) # top left
        next unless OUTER_CHARS.include?(bottom_left) # bottom left

        next unless OUTER_CHARS.include?(top_right) && top_right != bottom_left # top right
        next unless OUTER_CHARS.include?(bottom_right) && top_left != bottom_right # bottom right

        matches += 1 # 1835
      end
    end

    puts matches
  end
end