module RomanNumeral
  extend self

  VALUES = { 'I' => 1,
             'V' => 5,
             'X' => 10,
             'L' => 50,
             'C' => 100,
             'D' => 500,
             'M' => 1_000
           }
  SUBTRACTED_VALUES = { 'IV' => 4,
                        'IX' => 9,
                        'XL' => 40,
                        'XC' => 90,
                        'CD' => 400,
                        'CM' => 900
                      }

  # taken from http://stackoverflow.com/questions/267399/how-do-you-match-only-valid-roman-numerals-with-a-regular-expression
  VAILDATION_REGEX = Regexp.new /^M{0,3}(CM|CD|D?C{0,3})(XC|XL|L?X{0,3})(IX|IV|V?I{0,3})$/

  def roman_to_int roman
    if valid?(roman)
      # don't destroy the original
      to_be_eaten = roman.dup
      result = 0
      loop do
        possible_subtraction = to_be_eaten.slice(0..1)
        if SUBTRACTED_VALUES[possible_subtraction]
          result += SUBTRACTED_VALUES[to_be_eaten.slice!(0..1)]
        else
          result += VALUES[to_be_eaten.slice!(0)]
        end
        break if to_be_eaten.empty?
      end
      result
    else
      nil
    end
  end

  def valid? roman
    # !! to force the result to be explicitly true/false
    !!(!roman.empty? && VAILDATION_REGEX.match(roman))
  end
end
