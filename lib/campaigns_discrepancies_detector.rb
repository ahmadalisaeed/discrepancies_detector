# frozen_string_literal: true

require 'detector'

class CampaignsDiscrepanciesDetector
  attr_accessor :remote_campaigns

  def initialize(remote_campaigns)
    @remote_campaigns = remote_campaigns
  end

  def execute
    discrepancies = remote_campaigns.map do |remote|
      local = find_local(remote)
      detect(local, remote)
    end
    discrepancies.to_json
  end

  private

  def find_local(remote)
    Campaign.find_by_external_reference remote.reference
  end

  def detect(local, remote)
    {
      remote_reference: remote.reference,
      discrepancies: Detector.new(local: local, remote: remote).execute
    }
  end
end
