require "undead/driver"

module Undead
  class Agent
    DEFAULT_OPTIONS = {
      js_errors: false,
      timeout: 1000,
      headers: {
        'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X)"
      },
    }

    def initialize(options = {})
      @session = Driver.new(DEFAULT_OPTIONS.merge(options))
    end

    def get(url)
      @session.visit url
      @session.html
    end
  end
end
