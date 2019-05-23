# frozen_string_literal: true

RSpec.describe CampaignsDiscrepanciesDetector do
  let(:remote_campaign1) { RemoteCampaign.first }
  let(:remote_campaign2) { RemoteCampaign.all.second }
  let(:local_campaign1) do
    Campaign.create(external_reference: remote_campaign1.reference,
                    status: remote_campaign1.status,
                    ad_description: remote_campaign1.description)
  end
  let(:local_campaign2) do
    Campaign.create(external_reference: remote_campaign2.reference,
                    status: remote_campaign1.status,
                    ad_description: remote_campaign1.description)
  end

  before do
    local_campaign1
    local_campaign2
  end

  describe '#execute' do
    context 'when remote campaigns are empty' do
      it 'should return empty Array' do
        campaign_discrepancies = described_class.new([]).execute
        expect(campaign_discrepancies).to eq([].to_json)
      end
    end

    context 'when remote and local campaigns do not have discrepancies' do
      it 'should return empty discrepancies' do
        campaign_discrepancies = described_class.new([remote_campaign1]).execute
        expect(campaign_discrepancies).to eq([{ remote_reference: remote_campaign1.reference,
                                                discrepancies: {} }].to_json)
      end
    end

    context 'when remote and local campaigns differ' do
      it 'should return discrepancies' do
        campaign_discrepancies = described_class.new([remote_campaign2]).execute
        expect(campaign_discrepancies).to eq([{ remote_reference: remote_campaign2.reference,
                                                discrepancies: {
                                                  status: {
                                                    remote: remote_campaign2.status,
                                                    local: local_campaign2.status
                                                  },
                                                  description: {
                                                    remote: remote_campaign2.description,
                                                    local: local_campaign2.ad_description
                                                  }

                                                } }].to_json)
      end
    end
  end
end
