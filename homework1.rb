#Defining Graph class
class Graph
  attr_accessor :vertices, :query, :queue
  def initialize(num_of_vertices)
    @num_of_vertices=num_of_vertices
    @vertices=Array.new(num_of_vertices)
    @query=Array.new
    @queue=Array.new
  end

  #Process all queries in graph
  def process
    @query.each do |q|
      @vertices.each {|v| v.state=:open}
      if q[1]==0
        dfs(self,@vertices[q[:start]-1])
        print "\n"
      else
        @queue.clear
        bfs(self,@vertices[q[:start]-1])
      end
    end
  end
end

#Defining Node class
class Node
  attr_accessor :state, :adjacency_list
  def initialize
     @adjacency_list=Array.new
     @state=:open
  end
end

#Breadth First Search function
def bfs(graph, vertex)
  graph.queue << vertex
  while(!graph.queue.empty?) do
    vertex = graph.queue.shift
    vertex.state=:closed
    print graph.vertices.index(vertex)+1, " "
    for v in vertex.adjacency_list
     if v.state==:open && graph.queue.index(v)==nil
       graph.queue << v
     end
    end
  end
  print "\n"
end

#Depth First Search function
def dfs(graph, vertex)
  vertex.state = :closed
  print graph.vertices.index(vertex)+1, " "
  for v in vertex.adjacency_list
          if v.state==:open then
             dfs(graph, v)
          end
  end
end

#Define graph query structure
Query=Struct.new(:start, :algorithm)
#Get number of graphs in input file
num_of_graphs=Integer(STDIN.gets.chomp)
graphs=Array.new(num_of_graphs)
num_of_graphs.times { |x|
  #Read number of vertices in graph
  vertices=Integer(STDIN.gets.chomp)
  graphs[x] = Graph.new(vertices)
  #Create instances of nodes in graph
  vertices.times {|y|
    graphs[x].vertices[y]=Node.new
  }
  #Read the adjacency list
  vertices.times { |y|
    adjacent=STDIN.gets.chomp.split(" ")
    if Integer(adjacent[1])>0
      Integer(adjacent[1]).times { |z|
      graphs[x].vertices[Integer(adjacent[0])-1].adjacency_list << graphs[x].vertices[Integer(adjacent[2+z])-1]
      }
    end
  }
  #Read the query list
  begin
      query=STDIN.gets.chomp.split(" ")
      graphs[x].query << Query.new(Integer(query[0]), Integer(query[1])) if Integer(query[0])!=0
  end while Integer(query[0]) !=0
}

graphs.each { |g|
  puts 'graph ' + String(graphs.index(g)+1)
  g.process
}

