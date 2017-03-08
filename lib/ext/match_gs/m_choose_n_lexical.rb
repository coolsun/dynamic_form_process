require 'pp'

# Lexical search for n choose k
# nexksb
# n choose k
# store h at currentArray[k]
# input
#   n: full set of n elements
#   k: subset to be chosen
#   currentArray: nil to start
# return stop, currentArray
# if stop is true, then stop
# if stop is false, then continue
#
#       if currentArray[k-h] < n-h+1
#         h = 1
#       else
#         h = h + 1
#       end
def nexksb n, k, currentArray
  m2 = 0;
  h = 0;
  if (currentArray.nil?)
    currentArray = (1..k+1).to_a
    currentArray[k]=0
    return currentArray[0] == (n-k+1), currentArray
  else
    if currentArray[0] == (n-k+1)
      return currentArray[0] == (n-k+1), currentArray
    else

      h = currentArray[k]
      #puts "n=#{n}, h=#{h}, currentArray[k-h]=#{currentArray[k-h]}, n-h+1=#{n-h+1}"

      if currentArray[k-h] < n-h+1
        h = 1
      else
        h = h + 1
      end
      m2 = currentArray[k-h]
      currentArray[k] = h

      for j in 1..h
        currentArray[k+j-h-1] = m2 + j
      end
      return currentArray[0] == (n-k+1), currentArray
    end
  end
end

#currentArray = nil
#result = false
#puts "begin of output"
#while !result
#result, currentArray = nexksb(10, 2, currentArray)
#pp currentArray
#end
#puts "end of output"
