require_relative 'roman_numeral'

class MgttgLogic

  attr_accessor :resources, :aliases, :file_name

  ALIAS_REGEX = Regexp.new /^(?<alias>\w+) is (?<roman>[IVXLCDM])$/
  ASSIGNMENT_REGEX = Regexp.new /(?<number_alias>(\w+\s)+)(?<resource>\w+) is (?<credits>\d+) Credits/
  QUESTION_1 = Regexp.new /how much is(?<number_alias>(\s\w+)+) ?/
  QUESTION_2 = Regexp.new /how many Credits is(?<number_alias>(\s\w+)+) (?<resource>\w+) ?/

  def set_alias line
    match = ALIAS_REGEX.match line
    self.aliases[match[:alias]] = match[:roman]
  end

  def assign_resource line
    match = ASSIGNMENT_REGEX.match(line)
    stripped_alias_string = match[:number_alias].strip
    int_units = convert_alias_to_int stripped_alias_string
    float_units = int_units.to_f
    resource_name = match[:resource]
    credits = match[:credits].to_i
    self.resources[resource_name] = credits / float_units
  end

  def question_1 line
    match = QUESTION_1.match line
    stripped_alias_string = match[:number_alias].strip
    answer = convert_alias_to_int stripped_alias_string
    "#{stripped_alias_string} is #{answer}"
  end

  def question_2 line
    match = QUESTION_2.match line
    stripped_alias_string = match[:number_alias].strip
    units = convert_alias_to_int stripped_alias_string
    answer = (resources[match[:resource]] * units).round
    "#{stripped_alias_string} #{match[:resource]} is #{answer} Credits"
  end

  def convert_alias_to_int stripped_alias_string
    split_alias_string = stripped_alias_string.split(' ')
    roman = split_alias_string.reduce('') {|sum,a| sum << aliases[a];sum }
    RomanNumeral.roman_to_int roman
  end

  def initialize file_name
    self.file_name = file_name
    self.aliases = {}
    self.resources = {}
  end

  def run
    File.foreach(file_name) do |line|
      line.chomp!
      case
      when ALIAS_REGEX.match(line)
        set_alias line
      when ASSIGNMENT_REGEX.match(line)
        assign_resource line
      when QUESTION_1.match(line)
        response = question_1 line
        puts response
      when QUESTION_2.match(line)
        response = question_2 line
        puts response
      else
        puts 'I have no idea what you are talking about'
      end
    end
  end
end
