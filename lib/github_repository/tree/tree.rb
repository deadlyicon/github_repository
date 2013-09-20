class GithubRepository::Tree::Tree < GithubRepository::Tree::Child

  include Enumerable

  def tree
    @tree ||= ::GithubRepository::Tree.new(
      owner:  parent.owner,
      repo:   parent.repo,
      client: parent.client,
      sha:    sha
    )
  end

  def each &block
    tree.each &block
  end

  def [] path
    tree[path]
  end

  def children
    tree.children
  end

  def subdirectory?
    mode == "040000"
  end

end
