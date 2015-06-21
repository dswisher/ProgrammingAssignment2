## Functions to invert a matrix and cache the results

## Create a special matrix that supports caching of its inverse
## Example usage:
##   A <- makeCacheMatrix(matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2))

makeCacheMatrix <- function(x = matrix()) {
    # The cached inverse
    inv <- NULL
    
    # Set the matrix data and clear the inverse
    set <- function(y) {
        x <<- y
        inv <<- NULL
    }
    
    # Get the matrix data
    get <- function() {
        x
    }
    
    # Set the inverse
    setInverse <- function(i) {
        inv <<- i
    }
    
    # Get the inverse
    getInverse <- function() {
        inv
    }
    
    # Return the cache matrix
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
}


## Returns the inverse of a cached matrix
## Example usage:
##   A <- makeCacheMatrix(matrix(c(1, 2, 3, 4), nrow = 2, ncol = 2))
##   cacheSolve(A)
##   cacheSolve(A)   # should come from the cache

cacheSolve <- function(x, ...) {
    # Try to get the inverse from the cached matrix; if one is found, use it
    inv <- x$getInverse()
    if (!is.null(inv)) {
        print("using cached data")
        return (inv)
    }
    
    # Compute the inverse by fetching the data and calling solve
    data <- x$get()
    inv <- solve(data)
    
    # Save the inverse for subsequent invocations and return it
    x$setInverse(inv)
    inv
}
