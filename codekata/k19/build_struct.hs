
-- determine if two words are a word chain

wordChain word1 word2 = length(word1) == length(word2) && wordChainWithCount word1 word2 1

wordChainWithCount [] [] 0 = True
wordChainWithCount [] [] _ = False
wordChainWithCount (x:xs) (y:ys) z = if x == y
                                 then wordChainWithCount xs ys z
                                 else if z > 0
                                      then wordChainWithCount xs ys (z - 1)
                                      else False
