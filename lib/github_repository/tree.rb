class GithubRepository::Tree

  autoload :Subtree, 'github_repository/tree/subtree'
  autoload :Blob,    'github_repository/tree/blob'

  include Enumerable

  def initialize options
    @owner  = options.fetch(:owner)
    @repo   = options.fetch(:repo)
    @sha    = options.fetch(:sha)
    @client = options[:client]
  end

  attr_reader :owner, :repo, :sha

  def inspect
    %{#<#{self.class} #{owner}/#{repo} #{sha}>}
  end

  def client
    @client ||= GithubRepository::Client.new
  end

  def data
    @data || reload!
  end

  def reload!
    @children = nil
    @data = client.get("/repos/#{owner}/#{repo}/git/trees/#{sha}")
  end

  def url
    data["url"]
  end

  def children
    @children ||= data["tree"].map do |member_data|
      case member_data["type"]
      when "blob"
        GithubRepository::Tree::Blob.new(
          parent: self,
          mode:   member_data["mode"],
          type:   member_data["type"],
          sha:    member_data["sha"],
          path:   member_data["path"],
          url:    member_data["url"],
        )
      when "tree"
        GithubRepository::Tree::Subtree.new(
          parent: self,
          mode:   member_data["mode"],
          type:   member_data["type"],
          sha:    member_data["sha"],
          path:   member_data["path"],
          url:    member_data["url"],
        )
      end
    end
  end

  def each &block
    children.each &block
  end

  def [] path
    children.find do |member|
      member.path == path
    end
  end

end
