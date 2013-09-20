require 'spec_helper'

describe GithubRepository do

  it "should work like this" do

    rails = GithubRepository['rails/rails']
    rails4 = rails.commit('375d9a0a7fb329b0fbbd75a13e93e53a00520587')

    expect(rails4.tree.ls.map(&:path).to_set).to eq %w{
      .gitignore
      .travis.yml
      .yardopts
      CONTRIBUTING.md
      Gemfile
      RAILS_VERSION
      README.md
      RELEASING_RAILS.rdoc
      Rakefile
      actionmailer
      actionpack
      activemodel
      activerecord
      activesupport
      ci
      guides
      install.rb
      load_paths.rb
      rails.gemspec
      railties
      tasks
      tools
      version.rb
    }.to_set

    expect(rails4['RAILS_VERSION'].content).to eq "4.0.0\n"

    # rails.master.head.tree.members.map(&:path)
    binding.pry

    # rails.master.head.tree['Gemfile'].content
    # expect(repo['README.md'].to_s).to eq('this is the readme')

  end

end
