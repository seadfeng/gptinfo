require 'json'
require 'forwardable'
module Gptinfo
  class Parser
    extend Forwardable
    attr_reader :hash, :tools, :files, :product_features, :gizmo

    def_delegators :hash, :dig
    def_delegators :gizmo, *Gptinfo::GIZMO_FIELDS, *Gptinfo::GIZMO_DISPLAY_FIELDS

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

    def tool_types
      tools.map{|f| f.type }.uniq
    end

    def file_types
      files.map{|f| f.type }.uniq
    end

    def files_total_size
      files.map{|f| f.size }.sum
    end

    def files_total_size_tokens
      files.map{|f| f.file_size_tokens }.compact.sum
    end
  end
end

require_relative 'file'
require_relative 'gizmo'
require_relative 'tool'
require_relative 'product_features'