# frozen_string_literal: true

RSpec.describe Codebreaker::Storage do
  after { File.delete 'test_file.yml' }

  it 'create new storage' do
    storage = described_class.new('test_file.yml')
    store = storage.new_store
    store.transaction { store[:winners] = [] }
    expect(storage.storage_exists?).to be true
  end
end
