class GithubRepository::File

  def initialize options
    @owner  = options.fetch(:owner)
    @repo   = options.fetch(:repo)
    @sha    = options.fetch(:sha)
    @client = options[:client]

    @path     = options[:path]
    @mode     = options[:mode]
    @size     = options[:size]
    @url      = options[:url]
    @content  = options[:content]
    @encoding = options[:encoding]
  end

  def initialize repo, data
    @repo = repo
    @sha  = data.fetch("sha")
    @data = data
  end

  attr_reader :repo, :sha, :path, :mode

  def blob
    @blob ||= ::GithubRepository::Blob.new(
      owner:  owner,
      repo:   repo,
      client: client,
      sha:    sha,
    )
  end

  def size
    data["size"] || blob.size
  end

  def url
    data["url"] || blob.url
  end

  def content
    if @encoding == 'base64'
      @content = Base64.decode64(@content)
      @encoding = @content.encoding.to_s
    end
    @content
  end

  def encoding
    @encoding ||= blob.encoding
  end

end
