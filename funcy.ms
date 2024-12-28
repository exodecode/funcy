tail = function(lst); return lst[1:]; end function
head = function(lst); return lst[0]; end function
init = function(lst); return lst[:-1]; end function
last = function(lst); return lst[-1]; end function

Func = {}

func = function(f)
  a = new Func
  a.unwrap = @f
  return a
end function

Func.A = function(x)
  f = @self.unwrap
  return @f(x)
end function

Func.C = function(g)
  lambda = function(x)
    return self.unwrap(@g, x)
  end function

  c = new Func
  c.unwrap = @lambda
  return c
end function

Func.unwrap = function()
  lambda = function()
    return @self.unwrap
  end function

  return @lambda
end function

B = function(f, g)
  lambda = function(x)
    return f(@g(x))
  end function

  c = new Func
  c.unwrap = @lambda
  return c
end function

C = function(f, g)
  lambda = function(x)
    return f(@g, x)
  end function

  c = new Func
  c.unwrap = @lambda
  return c
end function

inRange = function(low, high)
  inRangeWrapper = function(n)
    return n >= low and n <= high
  end function

  return @inRangeWrapper
end function

equalTo = function(value)
  equalToWrapper = function(n)
    return n == value
  end function

  return @equalToWrapper
end function

lessThan = function(value)
  equalToWrapper = function(n)
    return n < value
  end function

  return @equalToWrapper
end function

greaterThan = function(value)
  equalToWrapper = function(n)
    return n > value
  end function

  return @equalToWrapper
end function

splitOn=function(delimiter)
  splitOnWrapper = function(str)
    return split(str, delimiter)
  end function

  return @splitOnWrapper
end function

deltas = function(lst)
  return zipWith(@subtract, tail(lst), init(lst))
end function

signum = function(n)
  if n > 0 then
    return 1
  else if n < 0 then
    return -1
  else
    return 0
  end if
end function

//checks if value is in list (untested)
contains = function(lst, x)
  return any(@equalTo(x), lst)
end function

// remove duplicates in a list (untested)
nub = function(lst)
  res = []
  for elem in lst
    if not contains(res, elem) then; res += [elem]; end if
  end for
  return res
end function
// ----

// transpose :: [[a]] -> [[a]]
transpose = function(matrix)
  if not matrix or not(head(matrix)) then
    return []
  end if

  return [fmap(@head, matrix)] + transpose(fmap(@tail, matrix))
end function

// fmap :: (a -> b) -> [a] -> [b]
fmap = function(func, lst)
  if not lst then
    return []
  end if
  return [func(head(lst))] + fmap(@func, tail(lst))
end function

// filter :: (a -> bool) -> [a] -> [a]
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

//compose=function(f, g)
//  wrapper=function(xs)
//    return f(@g, xs)
//  end function
//
//  return @wrapper
//end function

curry = function(f, x)
  curryWrapper = function(y)
    return @f(x, y)
  end function
  return @curryWrapper
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

// returns true if all the elements in a list satisfy the given condition
// some examples could be checking if all numbers in a list are even
// or if the numbers are less than a certain value
all = function(func, list)
  for elem in list
    if not func(elem) then; return false; end if
  end for
  return true
end function

// returns true if any of the elements in a list satisfy the given condition
// some examples could be checking if any numbers in a list are even
// or if any of the numbers are less than a certain value
any = function(func, list)
  for elem in list
    if func(elem) then; return true; end if
  end for
  return false
end function

positive = function(n)
  return signum(n) == 1
end function

zero = function(n)
  return n == 0
end function

negative = function(n)
  return signum(n) == -1
end function

words = function(str)
  return fmap(@splitOn(" "), str)
end function

//sort by removing elements that are out of order
stalinSort = function(lst)
  prev = head(lst)
  res = [prev]
  for i in range(1, len(lst) - 1)
    elem = lst[i]
    if elem >= prev then
      res += [elem]
      prev=elem
    end if
  end for
  return res
end function

reverse = function(lst)
  res = []
  for i in range(len(lst)-1); res += [lst[i]]; end for
  return res
end function


snd = function(m)
  return m.snd
end function

fst = function(m)
  return m.fst
end function

product = function(xs)
  return foldl(@multiply, 1, xs)
end function
