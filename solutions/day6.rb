# frozen_string_literal: true

require_relative "solution"

class Day6 < Solution
  MATRIX = File.readlines("./input/day6-input.txt", chomp: true).map(&:chars)
  DIRECTION_STEPS = [[0,-1],[1, 0],[0, 1],[-1, 0]]
  OBSTACLE_CHAR = '#'
  GUARD_CHAR = '^'
  EMPTY_SPACE = '.'

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
    loops_detected = 0
    0.upto(MATRIX.size-1) do |r|
      0.upto(MATRIX.first.size-1) do |c|
        next unless MATRIX[r][c] == EMPTY_SPACE

        obstacles_hit = Set.new
        x, y = guard_coordinates
        direction = 0 # up = 0, right = 1, down = 2, left = 3
        MATRIX[r][c] = OBSTACLE_CHAR

        while (0..MATRIX.first.size-1).cover?(x) && (0..MATRIX.size-1).cover?(y)
          dx, dy = DIRECTION_STEPS[direction]
          break unless (0..MATRIX.first.size-1).cover?(x + dx) && (0..MATRIX.size-1).cover?(y + dy)

          if MATRIX[y + dy][x + dx] == OBSTACLE_CHAR
            direction = (direction + 1) % DIRECTION_STEPS.size
            if obstacles_hit.include?([[y + dy],[x + dx],[direction]])
              loops_detected += 1
              break
            end
            obstacles_hit.add([[y + dy],[x + dx],[direction]])
          else
            x += dx
            y += dy
          end
        end

        MATRIX[r][c] = EMPTY_SPACE
      end
    end

    puts loops_detected
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