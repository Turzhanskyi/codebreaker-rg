# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  let(:winners) { YAML.load_file('spec/codebreaker/fixtures/statistics.yml')[:winners] }

  context 'when reads not sorted winners' do
    it 'reads sample file' do
      expect(winners.map(&:name)).to eq(%w[Darynka Vitalii Petro Ivan Vova])
    end
  end

  context 'when sorted winners' do
    it 'sort winners' do
      sorted_winners = described_class.sorted_winners(winners)
      expect(sorted_winners.map(&:name)).to eq(%w[Darynka Vitalii Petro Ivan Vova])
    end

    it 'decorates winners' do
      sorted_winners = described_class.sorted_winners(winners)
      top_users = described_class.decorated_top_users(sorted_winners)
      expected_fields = %i[rating name difficulty attempts_total attempts_used hints_total
                           hints_used]
      expect(top_users.sample.keys).to eq(expected_fields)
    end
  end
end
