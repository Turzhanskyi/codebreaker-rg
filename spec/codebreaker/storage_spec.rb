# frozen_string_literal: true

RSpec.describe Codebreaker::Storage do
  let(:storage_test_file) { 'test_file.yml' }
  let(:storage) { described_class.new(storage_test_file) }
  let(:store) { storage.new_store }

  after { File.delete storage_test_file }

  it 'creates new' do
    store.transaction { store[:winners] = [] }
    expect(storage.storage_exists?).to be true
  end
end
