class Line_segment
  attr_accessor :left,:right

  def initialize(l, r)
    @left=l
    @right=r
  end

  def size
    @right-@left
  end
end

class Coverage
  attr_accessor :line_end, :segments

  def initialize(line_end)
     @line_end=line_end
     @segments=Array.new
  end

  def add_line_segment(l,r)
     @segments.push(Line_segment.new(l,r))
  end

  def solve
    solution=Array.new
    iteration, right_side, sol, line_size = 0,0,0,0
    #Greedy algorithm outer loop
    while (iteration<@segments.length && right_side<@line_end)
      right_back=right_side
      inner_iteration=iteration
      #Rewind to interval matching line segment
      while  (inner_iteration<@segments.length)
        if !(@segments[inner_iteration].left <= right_back && @segments[inner_iteration].right >= right_back)
          inner_iteration=inner_iteration+1
        else
          break
        end
      end
      #Pick up best candidate
      while (inner_iteration<@segments.length && @segments[inner_iteration].left <= right_back && @segments[inner_iteration].right >= right_back)
        #Candidate found
        begin
        right_side=@segments[inner_iteration].right
        line_size=@segments[inner_iteration].size
        index=inner_iteration
        end if (@segments[inner_iteration].right > right_side && @segments[inner_iteration].size>=line_size)
        inner_iteration=inner_iteration+1
      end
      #Update solution
      if (right_back!=right_side)
       solution[sol]=Line_segment.new(@segments[index].left, @segments[index].right)
       sol=sol+1
      else
      #No candidate found
        puts
        puts '0'
        return
      end
      line_size=0
      iteration=inner_iteration
    end
    #Print solution
    puts
    puts sol
    solution.each {|s|
      puts String(s.left) + ' ' + String(s.right)
    }
  end

end


#Get number of test cases in input file
num_of_cases=Integer(STDIN.gets.chomp)
cases=Array.new(num_of_cases)
STDIN.gets.chomp
#Read and construct each test case
num_of_cases.times { |x|
  cases[x]=Coverage.new(Integer(STDIN.gets.chomp))
  c=0
  while !((pair=STDIN.gets.chomp).empty?)
    begin
    cases[x].add_line_segment(pair.split(' ').map(&:to_i).min, pair.split(' ').map(&:to_i).max)
      #Remove interval subsets
      if ((cases[x].segments.last.left==cases[x].segments[cases[x].segments.length-2].left) && (cases[x].segments.last.right>cases[x].segments[cases[x].segments.length-2].right) && c!=0)
        cases[x].segments.delete_at(cases[x].segments.length-2)
      end
    end unless ((pair.split(' ').map(&:to_i).min == 0) &&  (pair.split(' ').map(&:to_i).max== 0))
    c=c+1
    if (STDIN.eof?)
      break
    end
  end
  #Sort values by left side
  cases[x].segments.sort_by{|key |key.left}
}

#Print solution for each test case
cases.each{ |c|
  c.solve
}