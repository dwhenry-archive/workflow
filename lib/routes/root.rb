class Routes
  class Root < Sinatra::Base
    set :public, 'public/'

    get '/application.css' do
      sass :'stylesheets/application'
    end

    get '/' do
      @name, @ruby_version, @gems = self.class.sysinfo
      haml :sysinfo
    end

    def self.sysinfo
      [name,  ruby_version, gems]
    end

    private
    def self.name
      to_s
    end

    def self.ruby_version
      %x[ruby --version]
    end

    def self.gems
      gems =  %x[bundle list]
      gems.split('*')[1..-1]
    end
  end
end
  