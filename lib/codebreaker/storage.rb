# frozen_string_literal: true

module Codebreaker
  class Storage
    attr_reader :storage_file

    def initialize(storage_file = 'statistics.yml')
      @storage_file = storage_file
    end

    def new_store
      YAML::Store.new(storage_file)
    end

    def storage_exists?
      File.exist? storage_file
    end
  end
end
