# frozen_string_literal: true

module Codebreaker
  class User
    NAME_LENGTH_RANGE = (3..20).freeze

    attr_reader :name, :created_at, :errors

    def initialize(name)
      @name = name
      @created_at = DateTime.now
      @errors = []
    end

    def valid?
      validate
      errors.empty?
    end

    private

    def validate
      validate_not_empty
      validate_string if errors.empty?
      validate_min_length if errors.empty?
      validate_max_length if errors.empty?
    end

    def validate_not_empty
      errors << 'name cannot be blank' if name.to_s.strip.empty?
    end

    def validate_string
      errors << 'name should be a string' unless !!(name =~ /\A[a-zA-Z_0-9]+\z/)
    end

    def validate_min_length
      errors << "min name length is #{NAME_LENGTH_RANGE.min}" if name.length < NAME_LENGTH_RANGE.min
    end

    def validate_max_length
      errors << "max name length is #{NAME_LENGTH_RANGE.max}" if name.length > NAME_LENGTH_RANGE.max
    end
  end
end
