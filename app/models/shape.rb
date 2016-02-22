class Shape < ActiveRecord::Base
  belongs_to :guess

  VALID_SHAPE_TYPES = ['Square','Triangle','Circle']
  VALID_SHAPE_COLORS = ['Black','Green','Red','Blue']

  validates_inclusion_of :shape_type, in:VALID_SHAPE_TYPES
  validates_inclusion_of :color, in:VALID_SHAPE_COLORS
end
