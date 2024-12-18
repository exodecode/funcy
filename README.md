# funcy

A small functional library for miniscript! Experimental so your milage may vary.
<details>
<summary>Example code (solution for AoC 2024 Day 1 part A):</summary>

```ms
import "funcy";
map=@funcy.map; filter=@funcy.filter;
compose=@funcy.compose; notEmpty=@funcy.notEmpty;
sub=@funcy.sub; zipWith=@funcy.zipWith;
transpose=@funcy.transpose;

read=@funcy.read

linesSplit = map(@split, file.readLines("input.txt"))
sorted = map(@sort, map(
                compose(@map,@read),
                transpose(
                  map(compose(@filter,@notEmpty), linesSplit))))

deltas = map(@abs, zipWith(@sub, sorted[0], sorted[1]))
total = sum(deltas)

print total
```

</details>
