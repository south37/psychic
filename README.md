# Undead

Undead gets Dynamic HTML. Dynamic HTML are created by JavaScript.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'undead'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install undead

## Installing PhantomJS ##

You need at least PhantomJS 1.8.1.  There are *no other external
dependencies* (you don't need Qt, or a running X server, etc.)

### Mac ###

* *Homebrew*: `brew install phantomjs`
* *MacPorts*: `sudo port install phantomjs`
* *Manual install*: [Download this](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-macosx.zip)

### Linux ###

* Download the [32 bit](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-i686.tar.bz2)
or [64 bit](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-linux-x86_64.tar.bz2)
binary.
* Extract the tarball and copy `bin/phantomjs` into your `PATH`

### Windows ###
* Download the [precompiled binary](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-windows.zip)
for Windows

### Manual compilation ###

Do this as a last resort if the binaries don't work for you. It will
take quite a long time as it has to build WebKit.

* Download [the source tarball](https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.8-source.zip)
* Extract and cd in
* `./build.sh`

(See also the [PhantomJS building
guide](http://phantomjs.org/build.html).)

## Usage

### Get Dynamic HTML in Terminal

    $ undead http://example.com/

### Get Dynamic HTML in Ruby

`Undead.get` can get Dynamic HTML. `<script>` is evaluated, then HTML is created.

```ruby
response = Undead.get 'http://example.com/'  # GET http://example.com/

# Undead's response. The HTML p element is dynamicaly created.
# <!doctype html>
# <html>
# <head></head>
# <body>
#   <div id="main">
#     <p>Hello, World!</p>
#   </div>
#   <script>
#     var p = document.createElement("p");
#     var helloText = document.createTextNode("Hello, World!");
#     p.appendChild(helloText);
#     var main = document.getElementById("main");
#     main.appendChild(p);
#   </script>
# </body>

# Original response.
# <!doctype html>
# <html>
# <head></head>
# <body>
#   <div id="main"></div>
#   <script>
#     var p = document.createElement("p");
#     var helloText = document.createTextNode("Hello, World!");
#     p.appendChild(helloText);
#     var main = document.getElementById("main");
#     main.appendChild(p);
#   </script>
# </body>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/south37/undead.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

