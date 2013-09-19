class GithubRepository::Author

  def initialize(data)
    @name  = data.fetch(:name)
    @email = data.fetch(:email)
    @date  = data.fetch(:date)
  end

  attr_reader :name, :email, :date

end
