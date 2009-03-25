$graph = { }

def add_link(word1, word2)
  ($graph[word1] ||= []) << word2
  ($graph[word2] ||= []) << word1
end
