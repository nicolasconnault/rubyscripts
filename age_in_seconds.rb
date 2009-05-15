#!/usr/bin/ruby

def myage (seconds, measures)
    today = Time.now
    puts seconds
    birth = today - seconds
    retval = "You are %s old"
    string = ''
    measures.each do |measure|
      string += "%d #{measure}" % eval("today." + measure) - eval("birth." + measure)
    end
    puts retval % string
end

puts myage(979600, ['year', 'month', 'day', 'hour', 'minute'])
