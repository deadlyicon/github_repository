class GithubRepository::Sha

  def initialize repo, sha
    @repo, @sha = repo, sha
  end

  attr_reader :repo

  def to_s
    @sha
  end

end
