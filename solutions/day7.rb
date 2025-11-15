# frozen_string_literal: true

require_relative "solution"

class Day7 < Solution
  EXAMPLE = <<~INPUT
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
  INPUT

  def self.title = "Day 7: Bridge Repair"

  def self.description = <<~MSG
  MSG

  def self.solve
    sum = EXAMPLE.each_line.sum do |line|
      test_str, nums = line.split(':', 2)
      test = test_str.to_i
      a = nums.split.map!(&:to_i)

      can_reach_target = lambda do |total, index|
        return true  if total == test && index == a.length
        return false if total > test || index >= a.length
        can_reach_target.call(total + a[index], index + 1) ||
          can_reach_target.call(total * a[index], index + 1)
      end

      can_reach_target.call(a[0], 1) ? test : 0
    end

    puts sum # 1430271835320
  end

  def self.solve2
    sum = File.readlines("./input/day7.txt", chomp: true).sum do |line|
      test_str, nums = line.split(':', 2)
      test = test_str.to_i
      a = nums.split.map!(&:to_i)

      can_reach_target = lambda do |total, index|
        return true  if total == test && index == a.length
        return false if total > test || index >= a.length
        
        return (can_reach_target.call(total + a[index], index + 1) ||
          can_reach_target.call(total * a[index], index + 1) ||
             can_reach_target.call(concat_nums(total, a[index]), index + 1))
      end

      can_reach_target.call(a[0], 1) ? test : 0
    end

    puts sum # 456565678667482
  end

  private

  class << self
    def concat_nums(a, b)
      "#{a}#{b}".to_i
    end
  end
end
