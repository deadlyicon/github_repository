class GithubRepository::Branch

  def initialize repo, name
    @repo, @name = repo, name
  end

  attr_reader :repo, :name

  def head
    @head || reload!
  end

  def reload!
    sha = repo.client_get("/git/refs/heads/#{name}")["object"]["sha"]
    @head = ::GithubRepository::Commit.new(repo, sha)
  end

  def sha
    head.sha
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
