class GithubRepository::Commit

  def initialize options
    @owner  = options.fetch(:owner)
    @repo   = options.fetch(:repo)
    @sha    = options.fetch(:sha)
    @client = options[:client]
  end

  def inspect
    %{#<#{self.class} #{owner}/#{repo} #{sha}>}
  end

  attr_reader :owner, :repo, :sha

  def client
    @client ||= GithubRepository::Client.new
  end

  def data
    @data || reload!
  end

  def reload!
    @tree = @stats = @parents = @files = nil
    @data = client.get("/repos/#{owner}/#{repo}/commits/#{sha}")
  end

  def message
    data["commit"]["message"]
  end

  def tree
    @tree ||= ::GithubRepository::Tree.new(
      owner: owner, repo: repo, client: client, sha: data["commit"]["tree"]["sha"]
    )
  end

  def [] path
    tree[path]
  end

  def url
    data["url"] || data["commit"]["url"]
  end

  def comment_count
    data["commit"]["comment_count"]
  end

  def html_url
    data["html_url"]
  end

  def comments_url
    data["comments_url"]
  end

  def author
    ::GithubRepository::Author.new(data["author"])
  end

  def committer
    ::GithubRepository::Committer.new(data["committer"])
  end

  def parents
    @parents ||= data["parents"].map do |parent_data|
      ::GithubRepository::Commit.new(
        owner:  owner,
        repo:   repo,
        client: client,
        sha:    parent_data["sha"],
      )
    end
  end

  Stats = Struct.new(:total, :additions, :deletions)

  def stats
    @stats ||= Stats.new *data["stats"].values_at(*Stats.members.map(&:to_s))
  end

  def files
    @files ||= data["files"].map do |file_data|
      ::GithubRepository::File.new(repo, file_data)
      # TODO we might want to make this a ::GithubRepository::Commit::File
    end
  end

end
