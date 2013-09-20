class GithubRepository::Tree

  autoload :Child, 'github_repository/tree/child'
  autoload :Tree,  'github_repository/tree/tree'
  autoload :Blob,  'github_repository/tree/blob'

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
    @data = client.get("/repos/#{owner}/#{repo}/git/trees/#{sha}", query:{recursive: 1})
  end

  def url
    data["url"]
  end

  def children
    @children ||= data["tree"].map do |member_data|
      case member_data["type"]
      when "blob"; GithubRepository::Tree::Blob
      when "tree"; GithubRepository::Tree::Tree
      end.new(
        parent: self,
        mode:   member_data["mode"],
        type:   member_data["type"],
        sha:    member_data["sha"],
        path:   member_data["path"],
        url:    member_data["url"],
      )
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

  def ls
    children.reject{|x| x.path.include? '/' }
  end

end
