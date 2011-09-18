# Diffysh: A Collection of Diff Algorithms for Array and Hash


## Array

### Diff

Usage:

    [1, 3, 4, 99, 300].diff([3, 4, 54, 100, 300])
    => {:added=>[1, 99], :removed=>[54, 100]}
    ["j", "k", "o", "y", "z"].diff(["a", "j", "o", "z"])
    => {:added=>["k", "y"], :removed=>["a"]}

### Sequence Diff

This works well for arrays having sorted/sequential, unique elements. Also,
this runs faster than the above method for array size > 10.

Usage:

    [1, 3, 4, 99, 300].seq_diff([3, 4, 54, 100, 300])
    => {:added=>[1, 99], :removed=>[54, 100]}
    ["j", "k", "o", "y", "z"].seq_diff(["a", "j", "o", "z"])
    => {:added=>["k", "y"], :removed=>["a"]}


## Hash

### Detailed Diff

This shows which elements are added/changed and removed. Taken from active_support/core_ext/hash/diff

Usage:

    {:key => "value", :hello => "world", :world => "hello"}.detailed_diff(:hello => "sekai", :sushi => "hello", :key => "value")
    => {:added=>{:hello=>"world", :world=>"hello"}, :removed=>{:sushi=>"hello"}}


# Running Specs

    rspec spec/

