# frozen_string_literal: true

RSpec.describe FindCampaignDiscrepancies do
  describe '.execute' do
    it 'should return json array' do
      expect(JSON.parse(described_class.execute)).to be_an_instance_of(Array)
    end
  end
end
