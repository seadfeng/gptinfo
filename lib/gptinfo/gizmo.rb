# frozen_string_literal: true
module Gptinfo
  class Gizmo
    extend Forwardable
    attr_reader :hash, *Gptinfo::GIZMO_FIELDS, *Gptinfo::GIZMO_DISPLAY_FIELDS

    def_delegators :hash, :dig
    Gptinfo::GIZMO_FIELDS.each do |field|
      self.define_method(field) do
        get([field])
      end
    end

    Gptinfo::GIZMO_DISPLAY_FIELDS.each do |field|
      self.define_method(field) do
        display[field]
      end
    end
    
    def initialize(hash)
      @hash = hash
    end

    def get(keys)
      @hash.dig(*keys)
    end
  end
end