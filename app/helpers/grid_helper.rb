module GridHelper
  SIZE=10

  def gridsize
    SIZE
  end

  def getWalls(m, n)
    if ( (-~m * -~n ) % 6 == 3)
      "north"
    elsif ( (-~m * -~n ) % 7 == 4)
      "west"
    elsif ( (-~m * -~n ) % 8 == 5)
      "south"
    elsif ( (-~m * -~n ) % 5 == 2)
      "east"
    else
      ""
    end
  end
end
