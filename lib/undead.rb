module Undead
  class << self
    def agent
      @agent ||= Agent.new
    end

    def get(url)
      agent.get(url)
    end
  end
end

require "undead/agent"
require "undead/version"
