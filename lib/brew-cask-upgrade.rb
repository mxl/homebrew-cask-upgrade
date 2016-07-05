BREW_HOME = `brew --repository`.strip
CASK_HOME = "#{BREW_HOME}/Library/Taps/caskroom/homebrew-cask"
$LOAD_PATH.unshift("#{CASK_HOME}/lib")
$LOAD_PATH.unshift(File.expand_path("#{BREW_HOME}/Library/Homebrew"))

require 'vendor/homebrew-fork/global'
require 'hbc'

CASKROOM = Hbc.caskroom

def each_installed
  Hbc.installed.each_with_index do |name, i|
    cask = Hbc.load name.to_s
    yield({
      :cask => cask,
      :name => name.to_s,
      :installed => installed_versions(name)
    }, i)
  end
end

# Retrieves currently installed versions on the machine.
def installed_versions(name)
  Dir["#{CASKROOM}/#{name}/*"].map { |e| File.basename e }
end
