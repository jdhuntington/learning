data MyList a = Cons a (MyList a)
              | Nil
                deriving (Show)
                

toProperList (Cons a as) = a:(toProperList as)
toProperList Nil = []