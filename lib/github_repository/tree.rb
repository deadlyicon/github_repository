class GithubRepository::Tree

  include Enumerable

  def initialize repo, sha
    @repo, @sha = repo, sha
  end

  attr_reader :repo, :sha

  def data
    @data || reload!
  end

  def reload!
    @members = nil
    @data = repo.client_get("/git/trees/#{sha}")
  end

  def url
    data["url"]
  end

  def members
    @members ||= data["tree"].map do |member_data|
      case member_data["type"]
      when "blob"
        GithubRepository::File.new(repo, member_data)
      when "tree"
        GithubRepository::Directory.new(repo, member_data)
      end
    end
  end

  def each &block
    members.each &block
  end

  def [] path
    members.find do |member|
      member.path == path
    end
  end

end
