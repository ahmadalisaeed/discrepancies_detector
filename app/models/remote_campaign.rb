# frozen_string_literal: true

require 'activeresource'

class RemoteCampaign < ActiveResource::Base
  self.site = 'https://mockbin.org/bin/fcb30500-7b98-476f-810d-463a0b8fc3df'
end
