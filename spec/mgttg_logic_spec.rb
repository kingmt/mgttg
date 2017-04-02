require_relative '../lib/mgttg_logic'

describe MgttgLogic do
  let(:mgttg) { MgttgLogic.new 'foo.bar' }

  describe 'set_alias' do
    it 'sets an alias' do
      mgttg.set_alias 'glob is I'
      mgttg.set_alias 'prok is V'
      expect(mgttg.aliases['glob']).to eq 'I'
    end

    it 'allows overwriting an alias' do
      mgttg.set_alias 'glob is I'
      mgttg.set_alias 'prok is V'
      mgttg.set_alias 'glob is X'
      expect(mgttg.aliases['glob']).to eq 'X'
    end
  end

  context 'with aliases set,' do
    before :each do
      mgttg.aliases = { 'glob' => 'I',
                        'prok' => 'V',
                        'pish' => 'X',
                        'tegj' => 'L'}
    end

    describe 'set resource' do
      it 'sets value for Silver at 17' do
        mgttg.assign_resource 'glob glob Silver is 34 Credits'
        expect(mgttg.resources['Silver']).to eq 17
      end

      it 'sets value for Gold at 14450' do
        mgttg.assign_resource 'glob prok Gold is 57800 Credits'
        expect(mgttg.resources['Gold']).to eq 14450
      end

      it 'sets value for Iron at 195.5' do
        mgttg.assign_resource 'pish pish Iron is 3910 Credits'
        expect(mgttg.resources['Iron']).to eq 195.5
      end
    end

    describe 'question 1' do
      it 'converts "pish tegj glob glob" to 42' do
        expect(mgttg.question_1('how much is pish tegj glob glob ?')).to eq 'pish tegj glob glob is 42'
      end
    end

    describe 'question 2' do
      before :each do
        mgttg.resources = { 'Silver' => 17,
                            'Gold'   => 14450,
                            'Iron'   => 195.5}
      end

      [['how many Credits is glob prok Silver ?', 'glob prok Silver is 68 Credits'],
       ['how many Credits is glob prok Gold ?',   'glob prok Gold is 57800 Credits'],
       ['how many Credits is glob prok Iron ?',   'glob prok Iron is 782 Credits']
      ].each do |question, answer|
        it "answers the question '#{question}' with '#{answer}'" do
          expect(mgttg.question_2(question)).to eq answer
        end
      end
    end
  end
end
