require "undead/command"
require "undead/errors"
require 'multi_json'
require 'time'

module Undead
  class Browser
    ERROR_MAPPINGS = {
      'Poltergeist.JavascriptError'   => Undead::JavascriptError,
      'Poltergeist.FrameNotFound'     => Undead::FrameNotFound,
      'Poltergeist.InvalidSelector'   => Undead::InvalidSelector,
      'Poltergeist.StatusFailError'   => Undead::StatusFailError,
      'Poltergeist.NoSuchWindowError' => Undead::NoSuchWindowError,
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
      cmd = Undead::Command.new(name, *args)
      log cmd.message

      response = server.send(cmd)
      log response

      json = JSON.load(response)

      if json['error']
        klass = ERROR_MAPPINGS[json['error']['name']] || Undead::BrowserError
        raise klass.new(json['error'])
      else
        json['response']
      end
    rescue Undead::DeadClient
      restart
      raise
    end

    private

    def log(message)
      logger.puts message if logger
    end
  end
end
