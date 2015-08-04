  class User < ActiveRecord::Base
  #acts_as_paranoid
  #extend Rolify # added this so tests can run.
  #rolify
  
  validates :first_name       , :presence => true
  validates :last_name        , :presence => true
  validates :username         , :presence => true
  validates :email            , :presence => true
  validates :password         , :presence => true
  
  validates_uniqueness_of :username
  validates_uniqueness_of :email 
end
