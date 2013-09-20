class GithubRepository::Tree::Blob < GithubRepository::Tree::Child

  def blob
    @blob ||= ::GithubRepository::Blob.new(
      owner:  parent.owner,
      repo:   parent.repo,
      client: parent.client,
      sha:    sha
    )
  end

  def client
    blob.client
  end

  def data
    blob.data
  end

  def url
    blob.url
  end

  def raw_content
    blob.raw_content
  end

  def raw_encoding
    blob.raw_encoding
  end

  def content
    blob.content
  end

  def encoding
    blob.encoding
  end

  def size
    blob.size
  end

end
