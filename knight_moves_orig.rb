# 
# Fail!
# Tried several different ways, no success.
# 
# 
# 

# require 'set'


class Node
  attr_accessor :parent
  attr_accessor :children
  attr_accessor :position
  attr_accessor :index
  
  def initialize(position)
    @parent = nil
    @children = []
    @position = position
    @index = 0
  end

  def print
    children = @children.map {|el|
      el.position
    }
#    puts "@chidren size: #{@children.length}"
#    puts "parent: #{parent ? parent.position : 'nil'}, position: #{position}, children: #{children} "
  end
  
end

class Graph
  attr_reader :size
  
  def initialize
    @root = nil
    @size = 1
    @knight = KnightMovement.new
    @node_array = []
    populate
  end

  def knight_moves(current_pos, new_pos)
    current_node = @node_array.find(current_pos) {|el|
      el.position == current_pos
    }
    new_node = @node_array.find(new_pos) {|el|
      el.position == new_pos
    }

    if new_node == current_node
      return []
    end

    found_node = new_node
    retval = []
    while found_node != current_node
      retval.push(found_node)
      found_node = new_node.parent
    end
    retval
  end

  def populate
    @node_array = []
    8.times {|i|
      8.times {|j|
        @node_array.push(Node.new([i,j]))
      }
    }

    p @node_array.map {|el|
      el.position
    }
    puts "@node_array.length: #{@node_array.length}"
    
    @node_array.each_with_index {|node_array_el, index|
      node_array_el.index = index
      if index == 0
        @root = node_array_el
        puts "root: #{@root.position}, index: #{index}"
      end
      
      pos_array = @knight.moves(node_array_el.position)
      pos_array.each {|pos_array_item|
        found = @node_array.find(pos_array_item) {|search_el|
          search_el.position == pos_array_item
        }
        
         node_array_el.children.push(found)
         #          puts "populate -- parent's children count: #{node_array_el.children.length}, parent's pos: #{node_array_el.position}, child's pos: #{found.position}"
         found.parent = node_array_el
#         found.print
         @size += 1
         #        end
       }


      
#       pos_array = @knight.moves(node_array_el.position)
#       pos_array.each {|pos_array_item|
#         #        if !seen.include?(pos_array_item)
#         node = Node.new(pos_array_item)
#         node_array_el.children.push(node)
#         #          puts "populate -- parent's children count: #{node_array_el.children.length}, parent's pos: #{node_array_el.position}, child's pos: #{node.position}"
#         node.parent = node_array_el
#         node.print
#         #          seen << pos_array_item
#         @size += 1
#         #        end
#       }
     }


      

  end

  def print_graph
    puts "@node_array:"
    children = []
    @node_array.each{|el|
      parent = el.position
      children = []
      el.children.each {|child|
        children.push(child.position)
      }
      puts "@node_array -- index: #{el.index}, parent: #{parent}, children: #{children.inspect}"
    }

#     queue = []
#     node = @root
#     seen = Set.new
#     loop {
# #      puts "node: #{node}"
# #      puts "begin queue size: #{queue.length}"
# #      puts "node child count: #{node.children.length}, index: #{node.index}, node pos: #{node.position}"
#       node.children.each {|el|
# #        puts "node child: #{el.position}"
#         queue.push(el)
#       }
#       #      p "end queue size: #{queue.length} "
#       if !seen.include?(node)
#         puts " ( #{node.position} ) "
#         node = queue.shift
#         seen << node
#       end
#       break if seen.length >= 64
# #      break if queue.empty?
#     }
  end
  

#   def contains?(node)
#     retval = false
#     if @root.position == node.position
#       retval = true
#     else
#       queue = @root.children
#       while queue.length > 0
#         retval = contains?(queue.shift)
#       end
#     end
#     retval
#   end
  
end


class KnightMovement

  def initialize
    @move_array = [[1,-2],[1,2],[2,-1],[2,1],[-1,-2],[-1,2],[-2,-1],[-2,1]]
  end

  def moves(start_pos)
    retval = []
    @move_array.each {|el|
      new_pos = [el[0]+start_pos[0], el[1]+start_pos[1]]
      retval.push(new_pos) if legal?(new_pos)
    }
    retval
  end

  def legal?(move_pos)
    retval = true
    if move_pos[0] < 0 || move_pos[0] > 7
      retval = false
    end
    if move_pos[1] < 0 || move_pos[1] > 7
      retval = false
    end
    retval
  end

  # position: [col, row] (i.e. [x,y])
  def pos_to_index(position)
    position[1] * 8 + position[0]
  end
end

km = KnightMovement.new
p km.moves([2,2])
p km.moves([0,0])
p km.pos_to_index([0,0])
p km.pos_to_index([7,0])
p km.pos_to_index([0,1])
p km.pos_to_index([7,1])
p km.pos_to_index([0,2])
p km.pos_to_index([7,2])
p km.pos_to_index([7,7])
graph = Graph.new
puts "graph size: #{graph.size}"
graph.knight_moves([0,0], [5,5])
