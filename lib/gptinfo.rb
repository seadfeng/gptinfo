# frozen_string_literal: true

require_relative "gptinfo/version"

module Gptinfo
  class Error < StandardError; end

  GIZMO_FIELDS = %w( 
    id
    organization_id
    short_url
    author
    voice
    display
    share_recipient
    updated_at 
    last_interacted_at
    tags
    vanity_metrics
  ).freeze

  GIZMO_DISPLAY_FIELDS = %w( 
    name
    description
    welcome_message
    prompt_starters
    profile_picture_url
    categories
  ).freeze

  def self.parse(text)
    Parser.new(text)
  end
end
require_relative "gptinfo/parser"