require_relative '../lib/roman_numeral'

describe RomanNumeral do
  describe "valid?" do
    context 'returns true' do
      ['MMVI',
       'MCMXLIV',
       'XXXIX',
       'MCMIII'
      ].each do |numeral|
        it "for #{numeral}" do
          expect(RomanNumeral.valid?(numeral)).to be true
        end
      end
    end

    context 'returns false' do
      ['IIII',
       'IL',
       'XD',
       'VX',
       'LC',
       'DM',
       'DD',
       'LL',
       'VV',
       'XLIIV',
       'foobar',
       ''
      ].each do |numeral|
        it "for #{numeral}" do
          expect(RomanNumeral.valid?(numeral)).to be false
        end
      end
    end
  end

  describe "roman_to_int" do
    #  numeral    decimal
    [['I',        1],
     ['II',       2],
     ['III',      3],
     ['IV',       4],
     ['IX',       9],
     ['MMVI',     2006],
     ['MCMXLIV',  1944],
     ['XXXIX',    39],
     ['XLII',     42],
     ['MCMIII',   1903],
     ['IC',       nil],
     ['VX',       nil]
    ].each do |numeral, decimal|
      it "for #{numeral}" do
        expect(RomanNumeral.roman_to_int(numeral)).to eq decimal
      end
    end
  end
end
