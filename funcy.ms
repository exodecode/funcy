tail = function(lst); return lst[1:]; end function
head = function(lst); return lst[0]; end function
init = function(lst); return lst[:-1]; end function
last = function(lst); return lst[-1]; end function

// transpose :: [[a]] -> [[a]]
transpose = function(matrix)
  if not matrix or not(head(matrix)) then
    return []
  end if

  return [map(@head, matrix)] + transpose(map(@tail, matrix))
end function

// map :: (a -> b) -> [a] -> [b]
map = function(func, lst)
  if not lst then
    return []
  end if
  return [func(head(lst))] + map(@func, tail(lst))
end function

// map :: (a -> bool) -> [a] -> [a]
filter = function(func, lst)
  if not lst then
    return []
  else if func(head(lst)) then
    return [head(lst)] + filter(@func, tail(lst))
  else
    return filter(@func, tail(lst))
  end if
end function

foldl = function(func, acc, lst)
  if not lst then
    return acc
  end if

  acc = func(acc, head(lst))
  return foldl(@func, acc, tail(lst))
end function

foldr = function(func, acc, lst)
  if not lst then
    return acc
  end if

  return func(head(lst), foldr(@func, acc, tail(lst)))
end function

// zip :: [a] -> [b] -> [(a, b)]
zip = function(xs, ys)
  if not xs or not ys then
    return []
  else
    return [{"fst": head(xs), "snd": head(ys)}] + zip(tail(xs), tail(ys))
  end if
end function

//zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith = function(func, xs, ys)
  if not xs or not ys then
    return []
  end if

  //zipWithApply :: (a -> b -> c) -> ((a, b) -> c)
  zipWithApply = function(func)
    res = function(pair, acc)
      return [func(pair.fst, pair.snd)] + acc
    end function

    return @res
  end function

  return foldr(@zipWithApply(@func), [], zip(xs, ys))
end function

// arithmetic functions

add = function(a, b)
  return a + b
end function

sub = function(a, b)
  return a - b
end function

multiply = function(a, b)
  return a * b
end function

subtract = function(a, b)
  return a - b
end function

isEven = function(n)
  return n % 2 == 0
end function

isOdd = function(n)
  return n % 2 == 1
end function

compose=function(f, g)
  wrapper=function(xs)
    return f(@g, xs)
  end function

  return @wrapper
end function

notEmpty = function(elem)
  if elem then
    return true
  else
    return false
  end if
end function

read = function(s)
  return s.val
end function
