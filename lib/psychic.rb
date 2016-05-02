require "psychic/version"

module Psychic
  class << self
    def agent
      @agent ||= Agent.new
    end

    def get(url)
      agent.get(url)
    end
  end
end

require "psychic/agent"
