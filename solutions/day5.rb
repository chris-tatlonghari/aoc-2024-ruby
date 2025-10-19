# frozen_string_literal: true

require_relative "solution"

class Day5 < Solution
  FILE_CONTENT = File.read("./input/day5-input.txt")
  PAGE_RULE_REGEX = /(\d\d\|\d\d)/

  def self.title = "Day 5: Print Queue"

  def self.description = <<~MSG
    The input comes in two parts. The first is a series of rules for page ordering of the form X|Y where X is a page number
    that must come before page number Y. The second part is a CSV list of page updates. The goal of part 1 is to find all the valid page
    updates by line according to the ordering rules and sum the middle number for each line. The goal of part 2 is take all the invalid
    page update lines and sum their middle numbers after ordering them according to the page ordering rules.
  MSG

  def self.solve
    rules = rules_hash
    sum = FILE_CONTENT.split("\n\n").last.split("\n").sum do |update|
      seen, valid = [], true
      page_ordering = update.split(",")
      
      page_ordering.each do |page_number|
        if !rules[page_number].nil? && (seen & rules[page_number]).any?
          valid = false
          break
        end
        seen.append(page_number)
      end

      valid ? page_ordering[page_ordering.length / 2].to_i : 0
    end

    puts sum # 7074
  end

  def self.solve2
    rules = rules_hash
    sum = FILE_CONTENT.split("\n\n").last.split("\n").sum do |update|
      seen, valid = [], true
      page_ordering = update.split(",")
      
      page_ordering.dup.each.with_index do |page_number, i|
        if !rules[page_number].nil? && (seen & rules[page_number]).any?
          valid = false

          page_ordering.delete_at(i)
          index = page_ordering.find_index { |x| rules[page_number].include?(x) }
          page_ordering.insert(index, page_number)
        end
        seen.append(page_number)
      end

      valid ? 0 : page_ordering[page_ordering.length / 2].to_i
    end

    puts sum # 4828
  end

  private

  class << self
    def rules_hash
      rules = {}
      FILE_CONTENT.scan(PAGE_RULE_REGEX).each do |rule|
        rule_1, rule_2 = rule.first.split("|")
        rules[rule_1] ||= []
        rules[rule_1].append(rule_2)
      end

      rules
    end
  end
end