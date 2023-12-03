# frozen_string_literal: true

RSpec.describe Gptinfo do
  it "has a version number" do
    expect(Gptinfo::VERSION).not_to be nil
  end

  it "Parser" do
    text = File.read('data/g-HDJ2Bhvt1.json')
    gpt = Gptinfo.parse(text)
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
    unit_test.each do |k,v|
      expect(gpt.send(k)).to eq v
    end
  end
end
