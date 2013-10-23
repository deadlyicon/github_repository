require 'httparty'

class GithubRepository::Client

  SCHEME = 'https'
  HOST   = 'api.github.com'

  def initialize options={}
    @login    = options[:login]    || GithubRepository.login
    @password = options[:password] || GithubRepository.password
  end

  %w{get post put patch delete}.each do |method|
    define_method method do |path, options={}|
      request method, path, options
    end
  end

  def request method, path, options={}
    # path = ::File.join("/repos/#{@username}/#{@repo}", path)
    uri = URI("#{SCHEME}://#{HOST}")
    uri.path = path
    puts "#{method} #{uri}"

    options[:basic_auth] ||= {
      :username => @login,
      :password => @password
    } if @login && @password

    HTTParty.public_send(method, uri.to_s, options)
  end

end
