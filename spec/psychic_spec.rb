require 'spec_helper'

describe Psychic do
  it 'does something useful' do
    stub_request(:get, "www.example.com").
      to_return(:body => original_response)
    expect(Psychic.get("http://www.example.com").body).to eq result_response
  end

  def original_response
    <<-EOF
<!doctype html>
<html>
<head></head>
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
    EOF
  end

  def result_response
    <<-EOF
<!doctype html>
<html>
<head></head>
<body>
  <div id="main">
    <p>Hello, World!</p>
  </div>
  <script>
    var p = document.createElement("p");
    var helloText = document.createTextNode("Hello, World!");
    p.appendChild(helloText);
    var main = document.getElementById("main");
    main.appendChild(p);
  </script>
</body>
    EOF
  end
end
