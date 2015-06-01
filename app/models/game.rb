class Game < ActiveRecord::Base
	as_enum :status, open: 0, forming: 1, closed: 2
	# as_enum is a feature of the simple_enum gem (I'm lazy)
end
