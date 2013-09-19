require 'spec_helper'

describe GithubRepository do

  it "should work like this" do

    rails = GithubRepository['rails/rails']
    rails4 = rails.commit('375d9a0a7fb329b0fbbd75a13e93e53a00520587')
    rails.master.head.tree.members.map(&:path)
    rails.master.head.tree['Gemfile'].content

    expect(repo['README.md'].to_s).to eq('this is the readme')

  end

end
