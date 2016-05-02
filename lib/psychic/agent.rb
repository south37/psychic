require "capybara"
require "capybara/poltergeist"

module Psychic
  class Agent
    Capybara.javascript_driver = :poltergeist
    Capybara.register_driver :poltergeist do |app|
      Capybara::Poltergeist::Driver.new(app, { js_errors: false, timeout: 1000 })
    end
    Capybara.default_selector = :css

    def initialize
      @session = Capybara::Session.new(:poltergeist)
      @session.driver.headers = { 'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X)" }
    end

    def get(url)
      @session.visit url
      @session.html
    end
  end
end
