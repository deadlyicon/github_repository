class GithubRepository::Commit

  def initialize repo, sha
    @repo, @sha = repo, sha
  end

  def inspect
    %{#<#{self.class} #{repo.path} #{sha}>}
  end

  attr_reader :repo, :sha

  def data
    @data || reload!
  end

  def reload!
    @tree = @stats = @parents = @files = nil
    @data = repo.client_get("/commits/#{sha}")
  end

  def message
    data["commit"]["message"]
  end

  def tree
    @tree ||= ::GithubRepository::Tree.new(repo, data["commit"]["tree"]["sha"])
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
      ::GithubRepository::Commit.new(repo, parent_data["sha"])
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
