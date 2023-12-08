# frozen_string_literal: true
require 'json'

RSpec.describe Gptinfo do
  it "has a version number" do
    expect(Gptinfo::VERSION).not_to be nil
  end

  it "Parser" do
    text = File.read('data/g-HDJ2Bhvt1.json')
    gpt = Gptinfo.parse(text)

    # base info
    unit_test = { 
      id: 'g-HDJ2Bhvt1',
      name: 'The UX Kingdom of Answers',
      description: 'UX design mentor versed in ADA guidelines for inclusivity',
      welcome_message: 'Welcome to a deep dive into user-centric product research! How can I assist in your UX journey today?',
      organization_id: 'org-tn4tgkI4QSAEcYobOLcCXKP7',
      short_url: 'g-HDJ2Bhvt1-the-ux-kingdom-of-answers',
      share_recipient: 'link',
      updated_at: '2023-11-22T16:27:48.837598+00:00',
      last_interacted_at: nil
    }
    expect(gpt.file_types.sort).to eq ["application/pdf", "image/jpeg", "image/png"]
    expect(gpt.tool_types.map{|type| type.keys[0] }.sort).to eq ["browser", "dalle", "python"]
    expect(gpt.capabilities.sort).to eq ["Code Interpreter", "DALL·E Image Generation", "Web Browsing"]
    expect(gpt.files_total_size > 0).to eq true
    expect(gpt.files_total_size_tokens > 0).to eq true
  end

  it "Tool" do
    text = File.read('data/tools.json')
    types = JSON.parse(text).map{|item| Gptinfo::Tool.new(item) }
    expect(types.map(&:type).uniq.sort).to eq ["browser", "dalle", "plugins_prototype", "python"]

    # plugins_prototype
    plugins = types.filter {|item| item.type == "plugins_prototype" }
    expect(plugins.first.plugin?).to eq true
    expect(plugins.first.domain).to eq 'www.eventbriteapi.com'
  end

  it "File" do
    text = File.read('data/files.json')
    types = JSON.parse(text).map{|item| Gptinfo::File.new(item).type }
    expect(types.uniq.sort).to eq ["application/pdf", "image/jpeg", "image/png"]
  end
end
