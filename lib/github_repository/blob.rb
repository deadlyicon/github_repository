class GithubRepository::Blob

  def initialize repo, sha
    @repo, @sha = repo, sha
  end

  attr_reader :repo, :sha

  def data
    @data ||= repo.client_get("/git/blobs/#{sha}")
  end

  def url
    data["url"]
  end

  def content
    data["content"]
  end

  def encoding
    data["encoding"]
  end

  def size
    data["size"]
  end

end
