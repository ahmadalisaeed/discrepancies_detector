# frozen_string_literal: true

module FindCampaignDiscrepancies
  def self.execute
    CampaignsDiscrepanciesDetector.new(collect_remote_campaigns).execute
  end

  def self.collect_remote_campaigns
    RemoteCampaign.all
  end
end
