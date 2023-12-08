# frozen_string_literal: true

module Gptinfo
  class Tool
    FIELDS = %w( id type settings metadata ).freeze
    extend Forwardable
    attr_reader :hash, :capabiliy, *FIELDS

    FIELDS.each do |field|
       define_method(field) do
        get([field])
      end
    end

    def_delegators :hash, :dig

    def initialize(hash)
      @hash = hash
    end

    def capabiliy
      case type
      when 'python'
        'Code Interpreter'
      when 'dalle'
        'DALL·E Image Generation'
      when 'browser'
        'Web Browsing'
      when 'plugins_prototype'
        'Plugin'
      end
    end

    def plugin?
      type == 'plugins_prototype'
    end

    def domain
      metadata['domain'] unless metadata.empty?
    end

    def raw_spec
      JSON.parse(metadata['raw_spec']) unless metadata.empty?
    end

    private

    def get(keys)
      @hash.dig(*keys)
    end
  end
end