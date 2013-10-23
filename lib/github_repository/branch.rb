class GithubRepository::Branch

  def initialize options
    @owner  = options.fetch(:owner)
    @repo   = options.fetch(:repo)
    @client = options[:client]
    @branch = options.fetch(:branch)
  end

  attr_reader :owner, :repo, :client, :branch

  def client
    @client ||= GithubRepository::Client.new
  end

  def head
    @head || reload!
  end

  def reload!
    # sha = client.get("/git/refs/heads/#{branch}")
    sha = client.get("/repos/#{owner}/#{repo}/git/refs/heads/#{branch}")["object"]["sha"]
    @head = ::GithubRepository::Commit.new(
      owner:  owner,
      repo:   repo,
      client: client,
      sha:    sha,
    )
  end

  def sha
    head.sha
  end

  def [] path
    head[path]
  end



  # def data
  #   @data or reload!
  # end

  # def sha
  #   data["sha"]
  # end

  # def parents
  #   data["parents"].map do |parent_data|
  #     ::GithubRepository::Sha.new
  #   end
  # end

  # def reload!
  #   @data = repo.client.get("/repos/#{repo.path}/branches/#{name}")
  # end

end
