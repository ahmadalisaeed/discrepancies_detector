# frozen_string_literal: true

class Detector
  attr_accessor :local, :remote

  def initialize(local:, remote:)
    @local = local
    @remote = remote
  end

  def execute
    discrepancies = {}
    attributes_to_detect.each do |attribute|
      attribute_discrepancy = find_discrepancies_for(attribute)
      discrepancies[attribute[:remote].to_sym] = attribute_discrepancy if attribute_discrepancy
    end
    discrepancies
  end

  private

  def find_discrepancies_for(attribute)
    if remote&.send(attribute[:remote]) != local&.send(attribute[:local])
      {
        remote: remote&.send(attribute[:remote]),
        local: local&.send(attribute[:local])
      }
    end
  end

  def attributes_to_detect
    [
      { local: 'status', remote: 'status' },
      { local: 'ad_description', remote: 'description' }
    ]
  end
end
