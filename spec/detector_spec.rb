# frozen_string_literal: true

RSpec.describe Detector do
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
    context 'when local campaign is empty' do
      it 'should return discrepancies with local attribute nil' do
        discrepancies = described_class.new(remote: remote_campaign1, local: nil).execute

        expect(discrepancies).to include(status: { remote: remote_campaign1.status, local: nil },
                                         description: { remote: remote_campaign1.description, local: nil })
      end
    end

    context 'when no discrepancy between local and remote' do
      it 'should return an empty object' do
        discrepancies = described_class.new(remote: remote_campaign1, local: local_campaign1).execute
        expect(discrepancies).to eq({})
      end
    end

    context 'when there are discrepancies between local and remote' do
      it 'should return discrepancies' do
        discrepancies = described_class.new(remote: remote_campaign2, local: local_campaign2).execute
        expect(discrepancies).to include(status: { remote: remote_campaign2.status, local: local_campaign2.status },
                                         description: { remote: remote_campaign2.description, local: local_campaign2.ad_description })
      end
    end
  end
end
