# frozen_string_literal: true
module Gptinfo
  class File
    FIELDS = %w( id file_id type location ).freeze
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

    def get(keys)
      @hash.dig(*keys)
    end
  end
end