require 'spec_helper'

describe Psychic do
  describe ".get" do
    before do
      current_thread = Thread.current
      @server_thread = Thread.new do
        start_server(response: original_response) do
          current_thread.wakeup
        end
      end
      Thread.stop
    end

    after do
      Process.kill(:INT, Process.pid)
      @server_thread.join
    end

    it "returns a dynamically created HTML body" do
      expect(Psychic.get('http://127.0.0.1:8000').body.gsub("\n", '')).to eq result_response.gsub("\n", '')
    end
  end

  def original_response
    <<-EOF
<!DOCTYPE html>
<html>
<head>
</head>
<body>
  <div id="main"></div>
  <script>
    var p = document.createElement("p");
    var helloText = document.createTextNode("Hello, World!");
    p.appendChild(helloText);
    var main = document.getElementById("main");
    main.appendChild(p);
  </script>
</body>
</html>
    EOF
  end

  def result_response
    <<-EOF
<!DOCTYPE html>
<html>
<head>
</head>
<body>
  <div id="main"><p>Hello, World!</p></div>
  <script>
    var p = document.createElement("p");
    var helloText = document.createTextNode("Hello, World!");
    p.appendChild(helloText);
    var main = document.getElementById("main");
    main.appendChild(p);
  </script>
</body>
</html>
    EOF
  end

  def start_server(response:)
    server = WEBrick::HTTPServer.new({
      :BindAddress => '127.0.0.1',
      :Port => 8000,
      :StartCallback => Proc.new { yield }
    })
    server.mount_proc('/') do |req, res|
      res.body = response
    end
    trap(:INT) { server.shutdown }
    trap(:TERM) { server.shutdown }
    server.start
  end
end
