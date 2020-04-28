module Searchable
  def dfs(target)
    return self if self.value == target
    
    children.each do |child|
      search_result = child.dfs(target)
      return search_result unless search_result.nil?
    end
    
    nil
  end

  def bfs(target)
    line = [self]

    until line.empty?
      node = line.shift
      return node if node.value == target
      node.children.each { |child| line << child }
    end

    nil
  end
end