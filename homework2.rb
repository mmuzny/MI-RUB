Math.instance_eval do

  def square_intersect(square1, square2)
    nested=0

    if  (square1.left_edge > square2.right_edge || square1.right_edge < square2.left_edge || square1.top_edge < square2.bottom_edge || square1.bottom_edge > square2.top_edge)
      puts "Ctverce se ani nedotykaji."
      exit
    end

    if ((square1.bottom_edge == square2.top_edge)\
        || (square1.right_edge == square2.left_edge)\
        || (square1.top_edge == square2.bottom_edge)\
        || (square1.left_edge == square2.right_edge))
      puts "Obsah sjednoceni dvou ctvercu je #{square1.edge**2 + square2.edge**2}."
      exit
    end

    if (square1.x_axis<square2.x_axis && square1.right_edge > square2.left_edge)
      x_s=square1.right_edge-square2.left_edge
    elsif (square1.x_axis>square2.x_axis && square1.right_edge < square2.left_edge)
      x_s=square1.left_edge-square2.right_edge
    else
      x_s=[square1.edge,square2.edge].min
      nested=1
    end

    if (square1.y_axis>square2.y_axis && square1.bottom_edge < square2.top_edge)
      y_s=square2.top_edge-square1.bottom_edge
    elsif (square1.y_axis<square2.y_axis && square1.top_edge > square2.bottom_edge)
      y_s=square1.top_edge-square2.bottom_edge
    else
      y_s=[square1.edge,square2.edge].min
      begin
         puts "Obsah sjednoceni dvou ctvercu je #{[square1.edge,square2.edge].max**2}."
         exit
      end if nested==1
    end

    puts "Obsah sjednoceni dvou ctvercu je #{square1.edge**2 + square2.edge**2 - (y_s*x_s)}."
    exit
  end

end

class Square
  attr_accessor :edge, :x_axis, :y_axis
  attr_accessor :left_edge, :right_edge, :top_edge, :bottom_edge

  def initialize(edge,x,y)
    @edge=edge
    @x_axis=x
    @y_axis=y
    @left_edge=x-(edge/2)
    @right_edge=x+(edge/2)
    @top_edge=y+(edge/2)
    @bottom_edge=y-(edge/2)
  end

end

begin
puts "Zadejte delku hrany prvniho ctverce: "
edge=Float(STDIN.gets.chomp)
if (edge < 0)
  raise ArgumentError
end

puts "Zadejte x-ovou souradnici stredu prvniho ctverce: "
x=Float(STDIN.gets.chomp)
puts "Zadejte y-ovou souradnici stredu prvniho ctverce: "
y=Float(STDIN.gets.chomp)
sq_1=Square.new(edge,x,y)

puts "Zadejte delku hrany druheho ctverce: "
edge=Float(STDIN.gets.chomp)
if (edge < 0)
  raise ArgumentError
end
puts "Zadejte x-ovou souradnici stredu druheho ctverce: "
x=Float(STDIN.gets.chomp)
puts "Zadejte y-ovou souradnici stredu druheho ctverce: "
y=Float(STDIN.gets.chomp)
sq_2=Square.new(edge,x,y)

Math::square_intersect(sq_1, sq_2)

rescue ArgumentError
    puts "Spatny vstup."
end