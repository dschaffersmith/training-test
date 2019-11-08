# This is code to practice writing and debugging a function

#source(debugging.R)

a <- 10
b <- 50

# Function

simpleSum <- function(x,y){
  y = y + 10
  #browser()
  z = y + 20
  #print("Yay I got to line 9")
  #print(z)
  return(sum(x,z))
}

#simpleSum(a, b)

listOfSums <- function(n){
  m <- n*23
  o <- simpleSum(m, 23)
  return(o)
}

