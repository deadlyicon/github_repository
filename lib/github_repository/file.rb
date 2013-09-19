class GithubRepository::File

  def initialize repo, data
    @repo = repo
    @sha  = data.fetch("sha")
    @data = data
  end

  attr_reader :repo, :sha, :data

  def blob
    @blob ||= ::GithubRepository::Blob.new(repo, sha)
  end

  def path
    data["path"]
  end

  def mode
    data["mode"]
  end

  def size
    data["size"] || blob.size
  end

  def url
    data["url"] || blob.url
  end

  def content
    return @content if defined? @content
    @content = blob.content
    if encoding == 'base64'
      @content = Base64.decode64(@content)
      @encoding = @content.encoding.to_s
    end
    @content
  end

  def encoding
    @encoding ||= blob.encoding
  end

end
