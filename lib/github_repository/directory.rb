class GithubRepository::Directory

  def initialize repo, data
    @repo = repo
    @sha  = data.fetch("sha")
    @data = data
  end

  attr_reader :repo, :sha, :data

  def tree
    @tree ||= ::GithubRepository::Tree.new(repo, sha)
  end

  def path
    data["path"]
  end

  def mode
    data["mode"]
  end

  def url
    data["url"] || tree.url
  end

  def [] path
    tree[path]
  end

end
