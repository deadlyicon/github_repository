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
    owner, repo = path.split('/')
    new owner: owner, repo: repo
  end

  def initialize options
    @owner  = options.fetch(:owner)
    @repo   = options.fetch(:repo)
    @client = options[:client]
  end

  attr_reader :owner, :repo

  def client
    @client ||= GithubRepository::Client.new
  end

  # def sha sha
  #   ::GithubRepository::Sha.new(self, sha)
  # end

  def commit sha
    ::GithubRepository::Commit.new(
      owner:  owner,
      repo:   repo,
      client: client,
      sha:    sha,
    )
  end

  def branch branch
    ::GithubRepository::Branch.new(
      owner:  owner,
      repo:   repo,
      client: client,
      branch: branch,
    )
  end

  def master
    @master ||= branch :master
  end

  def [] path
    master[path]
  end

end
