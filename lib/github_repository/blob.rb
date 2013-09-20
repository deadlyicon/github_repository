class GithubRepository::Blob

  def initialize options
    @owner  = options.fetch(:owner)
    @repo   = options.fetch(:repo)
    @sha    = options.fetch(:sha)
    @client = options[:client]
  end

  def inspect
    %{#<#{self.class} #{owner}/#{repo} #{sha}>}
  end

  attr_reader :owner, :repo, :sha

  def client
    @client ||= GithubRepository::Client.new
  end

  def data
    @data ||= client.get("/repos/#{owner}/#{repo}/git/blobs/#{sha}")
  end

  def url
    data["url"]
  end

  def raw_content
    data["content"]
  end

  def raw_encoding
    data["encoding"]
  end

  def content
    decode_content!
    @content
  end

  def encoding
    decode_content!
    @encoding
  end

  def size
    data["size"]
  end

  private

  def decode_content!
    return if defined?(@content)
    if raw_encoding == 'base64'
      @content  = Base64.decode64(raw_content)
      @encoding = @content.encoding.to_s
    else
      @content  = raw_content
      @encoding = raw_encoding
    end
  end

end
