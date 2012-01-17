#Defining District class
class District
  attr_accessor :fireplace, :nodes, :start, :path, :num_of_nodes, :num_of_paths
  def initialize(service,fireplace)
    @num_of_nodes=21
    @start=service
    @fireplace=fireplace
    @nodes=Array.new
    @path=Array.new
    @num_of_paths=0
    @num_of_nodes.times{@nodes.push(Node.new)}
  end

  #Process all queries in graph
  def process
      dfs(self,@nodes[@start])
      puts "There are #{num_of_paths} routes from the firestation to streetcorner #{fireplace+1}."
  end
end

#Defining Node class
class Node
  attr_accessor :visited, :adjacency_list
  def initialize
     @adjacency_list=Array.new
     @visited=:false
  end
end


#Modified Depth First Search function
def dfs(district, node)
  if district.nodes.index(node)==district.fireplace
    district.path.push(district.nodes.index(node)+1)
    district.path.each {|n| print String(n)+" "}
    puts
    district.path.pop()
    district.num_of_paths=district.num_of_paths+1
  end
  district.path.push(district.nodes.index(node)+1)
  node.visited=:true
  for n in node.adjacency_list
          if district.nodes[n].visited==:false then
             dfs(district, district.nodes[n])
          end
  end

  node.visited = :false
  district.path.pop()

end

begin
#Define district array
districts=Array.new

#Read each city district
while (!STDIN.eof?)
   pair=STDIN.gets.chomp
   if (/^\d+\s\d+$/ !~ pair)
     raise ArgumentError
   end
   districts.push(District.new(pair.split(' ').map(&:to_i)[0]-1, pair.split(' ').map(&:to_i)[1]-1))
   pair=STDIN.gets.chomp
   while ((pair.split(' ').map(&:to_i).min != 0) &&  (pair.split(' ').map(&:to_i).max != 0))
      districts.last.nodes[pair.split(' ').map(&:to_i)[0]-1].adjacency_list.push(pair.split(' ').map(&:to_i)[1]-1)
      pair=STDIN.gets.chomp
   end
end

i=1
districts.each { |d|
  puts "CASE #{i}:"
  d.process
  i=i+1
}

rescue ArgumentError
    puts "Wrong input"
end