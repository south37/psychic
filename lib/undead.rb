require "undead/version"

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

require "undead/errors"
require "undead/command"
require "undead/browser"
require "undead/driver"
require "undead/agent"
