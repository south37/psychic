require "undead/browser"
require "undead/server"
require 'capybara/poltergeist'

module Undead
  class Driver
    DEFAULT_TIMEOUT = 30

    attr_accessor :options

    def initialize(options = {})
      @options = options
      headers = options.fetch(:headers, {})
    end

    def browser
      @browser ||= begin
        browser = Undead::Browser.new(server, client, logger)
        browser.js_errors  = options[:js_errors] if options.key?(:js_errors)
        browser.debug      = true if options[:debug]
        browser
      end
    end

    def server
      @server ||= Undead::Server.new(options[:port], options.fetch(:timeout) { DEFAULT_TIMEOUT })
    end

    def client
      @client ||= Capybara::Poltergeist::Client.start(server,
        :path              => options[:phantomjs],
        :window_size       => options[:window_size],
        :phantomjs_options => phantomjs_options,
        :phantomjs_logger  => phantomjs_logger
      )
    end

    def phantomjs_options
      list = options[:phantomjs_options] || []

      # PhantomJS defaults to only using SSLv3, which since POODLE (Oct 2014)
      # many sites have dropped from their supported protocols (eg PayPal,
      # Braintree).
      list += ["--ignore-ssl-errors=yes"] unless list.grep(/ignore-ssl-errors/).any?
      list += ["--ssl-protocol=TLSv1"] unless list.grep(/ssl-protocol/).any?
      list
    end

    def logger
      options[:logger] || (options[:debug] && STDERR)
    end

    def phantomjs_logger
      options.fetch(:phantomjs_logger, nil)
    end

    def headers
      browser.get_headers
    end

    def headers=(headers)
      browser.set_headers(headers)
    end

    def visit(url)
      browser.visit(url)
    end

    def html
      browser.body
    end
  end
end
