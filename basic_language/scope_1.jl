
x=1

for i=1:10
  @show x, i
end

@show x


NMax = 5

for i=1:NMax
  @show i, NMax
end


# welcome to our old scoping problem
NMax2 = 5
j=0

while(j<NMax2)
  j+=1
  @show j
end



