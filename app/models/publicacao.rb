class Publicacao < ActiveRecord::Base
  attr_accessible :abstract, :link, :titulo
  validates_presence_of :abstract, :titulo
end
