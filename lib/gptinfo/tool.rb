# frozen_string_literal: true

module Gptinfo
  class Tool
    FIELDS = %w( id type settings metadata ).freeze
    extend Forwardable
    attr_reader :hash, *FIELDS

    FIELDS.each do |field|
       define_method(field) do
        get([field])
      end
    end

    def_delegators :hash, :dig

    def initialize(hash)
      @hash = hash
    end

    private

    def get(keys)
      @hash.dig(*keys)
    end
  end
end