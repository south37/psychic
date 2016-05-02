require "capybara"
require "capybara/poltergeist"

module Psychic
  class Agent
    DEFAULT_OPTIONS = {
      js_errors: false,
      timeout:   1000,
    }

    Capybara.javascript_driver = :poltergeist
    Capybara.default_selector = :css

    def initialize(options = {})
      Capybara.register_driver :poltergeist do |app|
        Capybara::Poltergeist::Driver.new(app, DEFAULT_OPTIONS.merge(options))
      end
      @session = Capybara::Session.new(:poltergeist)
      @session.driver.headers = { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X)" }
    end

    def get(url)
      @session.visit url
      @session.html
    end
  end
end
