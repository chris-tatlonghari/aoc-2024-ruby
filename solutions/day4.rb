# frozen_string_literal: true

require_relative "solution"

class Day4 < Solution
  FILE_CONTENT = File.read("./input/day4-input.txt")
  DIRECTIONS = (-1..1).to_a.product((-1..1).to_a).reject! { |dx, dy| dx == 0 && dy == 0 }
  SEARCH_WORD = "XMAS"

  def self.title = ""

  def self.description = ""

  def self.solve
    matrix = FILE_CONTENT.lines.map(&:chomp)
    matches = 0

    0.upto(matrix.first.length - 1) do |x|
      0.upto(matrix.count - 1) do |y|
        matches += matches(matrix, x, y)
      end
    end

    puts matches # 2434
  end

  private 

  class << self
    def matches(matrix, x0, y0)
      DIRECTIONS.sum do |dx, dy|
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
end