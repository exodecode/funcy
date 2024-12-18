import "funcy";
fmap=@funcy.fmap; filter=@funcy.filter;
compose=@funcy.compose; notEmpty=@funcy.notEmpty;
sub=@funcy.sub; zipWith=@funcy.zipWith;
transpose=@funcy.transpose;
multiply=@funcy.multiply;
curry=@funcy.curry;

read=@funcy.read

//  PART A  //
linesSplit = fmap(@split, file.readLines("input.txt"))
lines = fmap(compose(@filter, @notEmpty), linesSplit)
transposed = fmap(compose(@fmap, @read), transpose(lines))

sorted = fmap(@sort, transposed)

deltas = fmap(@abs, zipWith(@sub, sorted[0], sorted[1]))
totalA = sum(deltas)
print "Part A: " + totalA

//  PART B  //
count = function(lst, n)
  counter=0
  for i in range(0, lst.len-1)
    if lst[i] == n then
      counter += 1
    end if
  end for
  return counter
end function

left=transposed[0]
right=transposed[1]
countNOnRight = @curry(@count, right)

occurences=fmap(@countNOnRight, left)
totalB=sum(zipWith(@multiply, occurences, left))

print "Part B: " + totalB
