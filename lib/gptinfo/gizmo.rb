# frozen_string_literal: true
module Gptinfo
  class Gizmo
    extend Forwardable
    attr_reader :hash

    def_delegators :hash, :dig
    Gptinfo::GIZMO_FIELD.each do |field|
      attr_reader field
    end

    Gptinfo::GIZMO_DISPLAY_FIELD.each do |field|
      attr_reader field
    end
    
    def initialize(hash)
      @hash = hash
      define_accessors
    end

    def get(keys)
      @hash.dig(*keys)
    end

    private

    def define_accessors
      Gptinfo::GIZMO_FIELD.each do |field|
        self.class.class_eval do
          self.define_method(field) do
            get([field])
          end
        end
      end

      Gptinfo::GIZMO_DISPLAY_FIELD.each do |field|
        self.class.class_eval do
          self.define_method(field) do
            display[field]
          end
        end
      end
    end
  end
end