# frozen_string_literal: true

module Gptinfo
  class Tool
    extend Forwardable
    attr_reader :hash

    def_delegators :hash, :dig

    def initialize(hash)
      @hash = hash
    end

    def get(keys)
      @hash.dig(*keys)
    end
  end
end