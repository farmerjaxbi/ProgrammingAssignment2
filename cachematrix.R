## Put comments here that give an overall description of what your
## functions do
# These functions first take in a matrix and set some variables within this function's environment.  It creates some sub
# functions which are then used in the second function to check for a previously calculated inverse matrix, or 
# one isn't found it creates a new inverse matrix and sets this to a variable back in the parent environment.

# This function sets the cache to what is put into the function argument.
# It then creates function  where arguments are passed in or reset from various frames 
# The output is returned in a list, which is a list of functions.


makeCacheMatrix <- function(x = matrix()) {
# initialise the inverse matrix (im) to null
    im <- NULL
# create a function called "get" to assign the matrix to it
    get <- function() x
# create a function called "set" and reset the parent inverse matrix (im) to null 
# and set x for the function variable to y
    set <- function(y = NULL) {
        x <<- y
        im <<- NULL
    }
# create a funciton called "setsolve" and set the passed in variable to im in the parent frame
    setsolve <- function(solve) im <<- solve
# create a function to return the inverse matrix from the parent frame.
    getsolve <- function() im
# output of this function is a list with all of the functions
    list(get = get, set = set, setsolve = setsolve, getsolve=getsolve)
}



# This function seeks to check the cache for the inverse matrix, if it finds it then it simply returns it, else it 
# inverses a new matrix into the cache.

cacheSolve <- function(x = NULL, ...) {

# Retrieve the cached matrix from environment of "x" and assign it to im
    im <- x$getsolve()
# check to see if it is null, ie has it already been set, if so then return this value.
    if(!is.null(im)) {
        message("getting cached data")
        return(im)
    }
# If the inverse hadn't been set then retrieve the matrix and then solve the inverse and set solved matrix
# in the environment of "x".
    else{
        local_matrix <-x$get()
        im<-solve(local_matrix)
        x$setsolve(im)
        im
    }
# Most importantly - have a nice day!
}
