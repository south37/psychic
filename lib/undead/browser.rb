require "capybara/poltergeist/errors"
require "capybara/poltergeist/command"
require 'multi_json'
require 'time'

module Undead
  class Browser
    ERROR_MAPPINGS = {
      'Poltergeist.JavascriptError'   => Capybara::Poltergeist::JavascriptError,
      'Poltergeist.FrameNotFound'     => Capybara::Poltergeist::FrameNotFound,
      'Poltergeist.InvalidSelector'   => Capybara::Poltergeist::InvalidSelector,
      'Poltergeist.StatusFailError'   => Capybara::Poltergeist::StatusFailError,
      'Poltergeist.NoSuchWindowError' => Capybara::Poltergeist::NoSuchWindowError
    }

    attr_reader :server, :client, :logger

    def initialize(server, client, logger = nil)
      @server = server
      @client = client
      @logger = logger
    end

    def visit(url)
      command 'visit', url
    end

    def body
      command 'body'
    end

    def js_errors=(val)
      @js_errors = val
      command 'set_js_errors', !!val
    end

    def debug=(val)
      @debug = val
      command 'set_debug', !!val
    end

    def command(name, *args)
      cmd = Capybara::Poltergeist::Command.new(name, *args)
      log cmd.message

      response = server.send(cmd)
      log response

      json = JSON.load(response)

      if json['error']
        klass = ERROR_MAPPINGS[json['error']['name']] || Capybara::Poltergeist::BrowserError
        raise klass.new(json['error'])
      else
        json['response']
      end
    rescue Capybara::Poltergeist::DeadClient
      restart
      raise
    end

    private

    def log(message)
      logger.puts message if logger
    end
  end
end
