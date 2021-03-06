
#File description comment, including purpose of program, inputs
# and outputs

#' sumSquares
#' @param data after principal component data
#' @param clusters the vector of integers indicating cluster membership
#' @export
sumSquares <- function(data, clusters){
  # Given the data and clusters vector this function computes
  # the between and within sum squered errors
  #
  # Args:
  #      data: After Principal component data
  #      clusters: The  vector of integers indicating the
  #                cluster to which each point is allocated.
  #
  # Returns:
  #      A list with two values SSW for Sum Squered Within
  #      and SSB for Sum Squered Between
  #
  # Error handeling

  cluster.number <- max(clusters)
  ssw <- rep(0,cluster.number)
  ssb <- rep(0,cluster.number)
  center <- apply(data,2,mean)
  for(i in 1:cluster.number){
    j <- clusters==i
    D <- data[j,]
    centerw <- apply(D,2,mean)
    for(k in seq_len(nrow(D))){
    ssw[i]<- ssw[i] + sum((D[k,]-centerw)^2)
    }
    ssb[i] <- sum(j)*sum((centerw-center)^2)
  }
  out <- list(SSW=sum(ssw),SSB=sum(ssb), SSWlist = ssw)
  return(out)
}

#' mapping
#' @description Using map database draw cluster on the US Map
#' @param  long A numeric vector of  longitude location of the points.
#' @param  lat A numeric vector of latitude location of the points.
#' @param  clusters The  vector of integers indicating the cluster to which each point is allocated.
#' @importFrom graphics points
#' @importFrom maps map.axes
#' @export

mapping <- function(long, lat, clusters){
  maps::map("state", xlim = c(-98, -65), ylim = c(35, 50),
            col = 'gray90', fill = TRUE)
  cluster.number <- max(clusters)
  maps::map.axes()
  for(i in 1:cluster.number){
    j <- clusters == i
    graphics::points(long[j], lat[j], pch = 19, col = i, cex = 0.25)
  }
}


