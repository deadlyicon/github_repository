require "github_repository/version"

class GithubRepository

  autoload :Client,    'github_repository/client'
  autoload :Commit,    'github_repository/commit'
  autoload :Sha,       'github_repository/sha'
  autoload :Branch,    'github_repository/branch'
  autoload :Blob,      'github_repository/blob'
  autoload :Tree,      'github_repository/tree'
  autoload :File,      'github_repository/file'
  autoload :Directory, 'github_repository/directory'
  autoload :Author,    'github_repository/author'

  def self.[] path
    new path: path
  end

  def initialize options
    @path = options.fetch(:path)
    @client = options[:client]
  end

  attr_reader :path

  def client
    @client ||= GithubRepository::Client.new
  end

  %w{get post put patch delete}.each do |method|
    define_method "client_#{method}" do |path, options={}|
      path = ::File.join("/repos/#{self.path}", path)
      client.public_send method, path, options
    end
  end

  # def sha sha
  #   ::GithubRepository::Sha.new(self, sha)
  # end

  def commit sha
    ::GithubRepository::Commit.new(self, sha)
  end

  def branch branch
    ::GithubRepository::Branch.new(self, branch)
  end

  def master
    @master ||= branch :master
  end

  def [] path
    master[path]
    # ::GithubRepository::File.new(self, path)
  end

end
