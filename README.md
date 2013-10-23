# GithubRepository

A simple API for interacting with a github repo via the v3 API

## Installation

Add this line to your application's Gemfile:

    gem 'github_repository'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install github_repository

## Usage

```Ruby

repo = GithubRepository.get('username/repository_name',
  login:    'your@emailaddress.com',
  password: 'y0uRP@55w0rD',
)

repo['Gemfile'].exist?
repo['Gemfile'].update('some content', :author_email => "foo@bar.com", :message => "fixed a bug")
repo['Gemfile'].delete
repo['Gemfile'].read
repo['Gemfile'].to_s
repo['config/database.yml']


repo.head # => Github::Repo::Sha

master = repo.branch('master') # => Github::Repo::Sha

master['Gemfile'].to_s

master.tree # => Github::Repo::Tree

master.blobs



rails = GithubRepository['rails/rails']
rails['README.md'].content


```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
