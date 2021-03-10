# frozen_string_literal: true

RSpec.describe Codebreaker::Statistics do
  let(:winners) { YAML.load_file('spec/codebreaker/fixtures/statistics.yml')[:winners] }
  let(:sorted_users_order) { %w[Katya Darynka Vitalii Petro] }
  let(:sorted_winners) { described_class.sorted_winners(winners) }
  let(:top_users) { described_class.decorated_top_users(sorted_winners) }
  let(:expected_table_fields) do
    %i[rating name difficulty attempts_total attempts_used hints_total hints_used]
  end

  context 'when reads not sorted winners' do
    it 'reads sample file' do
      expect(winners.map(&:user).map(&:name)).to eq(sorted_users_order)
    end
  end

  context 'when sorted winners' do
    it 'sort winners' do
      expect(sorted_winners.map(&:user).map(&:name)).to eq(sorted_users_order)
    end

    it 'decorates winners' do
      expect(top_users.sample.keys).to eq(expected_table_fields)
    end
  end
end
