Dir[Dir.pwd + "/app/**/*.rb"].each { |f| require f  }

class App < Service
  def initialize(path)
    @path = path.nil? ? Dir.pwd : path
  end

  def call
    puts "I will operate on #{@path}"
  end
end


warn "WARNING: Ignoring other arguments : #{ARGV[1..-1].inspect}" if ARGV.length > 1
App.call(ARGV.first)
