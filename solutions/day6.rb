# frozen_string_literal: true

require_relative "solution"

class Day6 < Solution
  MATRIX = File.readlines("./input/day6-input.txt", chomp: true).map(&:chars)
  DIRECTION_STEPS = [[0,-1],[1, 0],[0, 1],[-1, 0]]
  OBSTACLE_CHAR = '#'
  GUARD_CHAR = '^'

  def self.title = "Day 6: Guard Gallivant"

  def self.description = <<~MSG
    
  MSG

  def self.solve
    visited = Set.new
    x, y = guard_coordinates
    direction = 0 # up = 0, right = 1, down = 2, left = 3

    while (0..MATRIX.first.size-1).cover?(x) && (0..MATRIX.size-1).cover?(y)
      visited.add([x, y])

      dx, dy = DIRECTION_STEPS[direction]
      break unless (0..MATRIX.first.size-1).cover?(x + dx) && (0..MATRIX.size-1).cover?(y + dy)

      if MATRIX[y + dy][x + dx] == OBSTACLE_CHAR
        direction = (direction + 1) % DIRECTION_STEPS.size
      else
        x += dx
        y += dy
      end
    end

    puts visited.size
  end

  def self.solve2
    puts :unknown
  end

  private

  class << self
    def guard_coordinates
      x, y = 0, 0
      MATRIX.each_with_index do |row, row_i|
        if row.index(GUARD_CHAR)
          y, x = row_i, row.index(GUARD_CHAR)
          break
        end      
      end

      return x, y
    end
  end
end