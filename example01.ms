import "funcy";
fmap=@funcy.fmap; filter=@funcy.filter;
compose=@funcy.compose; notEmpty=@funcy.notEmpty;
sub=@funcy.sub; zipWith=@funcy.zipWith;
transpose=@funcy.transpose;

read=@funcy.read

linesSplit = fmap(@split, file.readLines("input.txt"))
sorted = fmap(@sort, fmap(
                compose(@fmap,@read),
                transpose(
                  fmap(compose(@filter,@notEmpty), linesSplit))))

deltas = fmap(@abs, zipWith(@sub, sorted[0], sorted[1]))
total = sum(deltas)

print total
