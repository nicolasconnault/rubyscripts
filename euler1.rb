#!/usr/bin/ruby
solution = 0
(0..1000).each do |n|
    if n % 3 == 0 || n % 5 == 0
        solution += n
    end
end
puts solution
