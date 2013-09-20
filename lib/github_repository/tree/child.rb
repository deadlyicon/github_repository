class GithubRepository::Tree::Child

  def initialize options
    @parent = options.fetch(:parent)
    @mode   = options.fetch(:mode)
    @type   = options.fetch(:type)
    @sha    = options.fetch(:sha)
    @path   = options.fetch(:path)
    @url    = options.fetch(:url)
  end

  attr_reader :parent, :mode, :type, :sha, :path, :url

  def inspect
    %{#<#{self.class} #{parent.owner}/#{parent.repo} #{path} #{sha}>}
  end

  # 100644 for file (blob),
  # 100755 for executable (blob),
  # 040000 for subdirectory (tree),
  # 160000 for submodule (commit)
  # 120000 for a blob that specifies the path of a symlink

  def file?
    mode == "100644"
  end

  def executable?
    mode == "100755"
  end

  def subdirectory?
    mode == "040000"
  end

  def submodule?
    mode == "160000"
  end

  def symlink?
    mode == "120000"
  end

end
