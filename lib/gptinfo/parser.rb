require 'json'
require 'forwardable'
module Gptinfo
  class Parser
    extend Forwardable
    attr_reader :hash, :tools, :files, :product_features, :gizmo

    def_delegators :hash, :dig
    def_delegators :gizmo, *Gptinfo::GIZMO_FIELD, *Gptinfo::GIZMO_DISPLAY_FIELD

    def initialize(text)
      @hash = JSON.parse(text)
    end

    def gizmo
      @gizmo ||= Gizmo.new(get('gizmo'))
    end

    def tools
      @tools ||= get('tools').map{|item| Tool.new(item) }
    end

    def files
      @files ||= get('files').map{|item| File.new(item) }
    end

    def product_features
      @product_features ||= ProductFeatures.new(get('product_features'))
    end

    def get(keys)
      @hash.dig(*Array(keys))
    end
  end
end

require_relative 'file'
require_relative 'gizmo'
require_relative 'tool'
require_relative 'product_features'