#!/usr/bin/ruby
def fibonacci n, fib1=1, fib2=0
  oldfib = fib1
  fib = fib1 + fib2
  fib2 = oldfib
  fib1 = fib

  if n > 0
    fib = fibonacci(n-1, fib1, fib2)
  end
  fib
end

n = 1
evenfibs = 0
while (fib = fibonacci(n)) <= 4000000
  if fib % 2 == 0
    evenfibs += fib
  end
  n += 1
end
puts evenfibs
