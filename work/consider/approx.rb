def close1(a,b,x)
  (a >= (b - x)) && (a <= (b + x))
end

def close2(a,b,x)
   (a / b - 1).abs <= x/b
end

def close3(a,b,x)
  ax, bx = a/x, b/x
  (ax >= (bx - 1)) && (a <= (bx + 1))
end

def close4(a,b,x)
  ax, bx = a/x, b/x
  (ax / bx - 1).abs <= 1/bx
end

def close5(a,b,x)
   (a - b).abs / [a.abs, b.abs].max <= x
end


try = [[1.0, 1.1, 0.2, true], [1.1, 1.0, 0.1, true], [1.0, 1.1, 0.01, false]]

try.each do |(a,b,x,r)|
  c1 = close1(a,b,x)
  c2 = close2(a,b,x)
  c3 = close3(a,b,x)
  c4 = close4(a,b,x)
  c5 = close5(a,b,x)

  puts "%f  %f  %f  %5s | %5s  %5s  %5s  %5s  %5s" % [a,b,x,r,c1,c2,c3,c4,c5] 
end

