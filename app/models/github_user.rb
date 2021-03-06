class GithubUser < ActiveRecord::Base
  has_many :authored_commits, :class_name => 'Commit', :foreign_key => 'author_github_user_id', dependent: :restrict_with_exception
  has_many :committed_commits, :class_name => 'Commit', :foreign_key => 'committer_github_user_id', dependent: :restrict_with_exception

  validates_presence_of :username
  validates_presence_of :email
end
