# frozen_string_literal: true
module Gptinfo
  class ProductFeatures
    extend Forwardable
    attr_reader :hash

    def_delegators :hash, :dig

    def initialize(hash)
      @hash = hash
    end

    def attachments_type
      get(%w(attachments type))
    end

    private

    def get(keys)
      @hash.dig(*keys)
    end
  end
end