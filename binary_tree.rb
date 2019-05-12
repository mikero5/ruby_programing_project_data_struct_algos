# 
# 
# 
# 
# 
# 
# 
# 


class Node
  attr_accessor :parent
  attr_accessor :left
  attr_accessor :right
  attr_accessor :value
  attr_accessor :spaces
  
  def initialize
    @parent = nil
    @left   = nil
    @right  = nil
    @value  = nil
    @spaces = ""
  end

end # class Node


class BinaryTree
  attr_reader :size
  
  def initialize
    @root = nil
    @size = 0
  end

  def build_tree(data_array)
    data_array.each {|el|
      insert(el, @root)
    }
  end # build_tree(data_array)

  def insert(value, root = @root)
    if root == nil
      root = Node.new
      root.value = value
      @size += 1
    else
      new_node = Node.new
      new_node.value = value
      search_node = root

      if value == search_node.value
        if search_node.right
          search_node.right.parent = new_node
          new_node.right = search_node.right
          new_node.parent = search_node
          search_node.right = new_node
        else
          search_node.right = new_node
          new_node.parent = search_node
        end
      elsif value < search_node.value
        if search_node.left
          insert(value, search_node.left)
        else
          insert_left_node(search_node, new_node)
        end
      else
        if search_node.right
          insert(value, search_node.right)
        else
          insert_right_node(search_node, new_node)
        end
      end
    end
    @root = root
  end # insert(value, root = @root)

  def breadth_first_search(value)
    retval = nil
    queue = [@root]
    while !queue.empty?
      node = queue.shift
      if node.left
        queue.push node.left
      end
      if node.right
        queue.push node.right
      end
      if node.value == value
        return node
      end
    end
    retval
  end # breadth_first_search(value)

  def depth_first_search(value)
    stack = []
    current_node = @root
    while current_node
      if value == current_node.value
        return current_node
      elsif value < current_node.value
        current_node = current_node.left
      else # value > current_node.value
        current_node = current_node.right
      end
      current_node
    end
  end # depth_first_search(value)

  def dfs_rec(value)
    return dfs_node(@root, value)
  end
  
  def breadth_first_print(indent = false)
    queue = [@root]
    while !queue.empty?
      node = queue.shift
      if node.left
        node.left.spaces = node.spaces + "   "
        queue.push(node.left)
      end
      if node.right
        node.right.spaces = node.spaces + "   "
        queue.push(node.right)
      end
      if indent
        puts " #{node.spaces}( #{node.value} )"
      else
        print " ( #{node.value} )"
      end
    end
    puts ""
  end # breadth_first_print(indent = false)
  
  def depth_first
    return depth_first_node(@root)
  end

  
  private
  def insert_right_node(parent_node, new_node)
    parent_node.right = new_node
    new_node.parent = parent_node
    @size += 1
  end

  def insert_left_node(parent_node, new_node)
    parent_node.left = new_node
    new_node.parent = parent_node
    @size += 1
  end

  def depth_first_node(node)
    retval = []
    if !node
      return retval
    end

    retval << depth_first_node(node.left)
    retval.push(node.value)
    retval << depth_first_node(node.right)
    retval.flatten!
  end # depth_first_node(node)

  def dfs_node(node, value)
    if !node
      return nil
    end
    retval = dfs_node(node.left, value)
    if retval
      return retval
    end
    if node.value == value
      return node
    end
    dfs_node(node.right, value)
  end # dfs_node(node)

end



tree = BinaryTree.new
tree.build_tree([3,5,2,4,1])
puts "tree size: #{tree.size}"
p tree.depth_first
tree.breadth_first_print
puts "#{tree.breadth_first_search(1) ? tree.breadth_first_search(1).value : 'nil'}"
puts "#{tree.breadth_first_search(3) ? tree.breadth_first_search(3).value : 'nil'}"
puts "#{tree.breadth_first_search(5) ? tree.breadth_first_search(5).value : 'nil'}"
puts "#{tree.breadth_first_search(7) ? tree.breadth_first_search(7).value : 'nil'}"

tree1 = BinaryTree.new
tree1.build_tree([9,1,8,2,7,3,6,4,5])
tree1.breadth_first_print
p tree1.depth_first

puts (tree1.depth_first_search(5)).value
p tree1.depth_first_search(15)

puts (tree1.dfs_rec(5)).value
p tree1.dfs_rec(15)
