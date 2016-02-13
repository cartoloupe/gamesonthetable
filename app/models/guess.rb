class Guess < ActiveRecord::Base
  belongs_to :player
  has_many :shapes
end
