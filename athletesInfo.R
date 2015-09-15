# Read data from CSV
# Download from http://www.danasilver.org/static/assets/sochi-2014-athletes/athletes.csv
# See below for faster option.
WD <- getwd() # Get current Directory path

athletes <- read.csv('athletes.csv')

# Subset data
ath <- athletes[athletes$sport=='Curling',c('height','weight')]
ath <- ath[complete.cases(ath),]

# ALTERNATIVELY instead of downloading
ath <- structure(list(height = c(1.73, 1.78, 1.7, 1.73, 1.71, 1.93, 
                                 1.7, 1.69, 1.84, 1.75, 1.83, 1.8, 1.8, 1.64), weight = c(66L, 
                                                                                          84L, 74L, 66L, 73L, 80L, 58L, 60L, 88L, 85L, 80L, 71L, 85L, 69L
                                 )), .Names = c("height", "weight"), row.names = c(536L, 624L, 
                                                                                   640L, 820L, 930L, 949L, 1191L, 1632L, 1818L, 2349L, 2583L, 2609L, 
                                                                                   2641L, 2696L), class = "data.frame")

# Plot 1 Dimension (just height)
png('pca1-stripchart.png')
stripchart(ath$height, col="green", pch=19, cex=2, 
           xlab="Height (m)", 
           main="Curlers at Sochi 2014 Winter Olympics")
dev.off()

# Plot 2 Dimensions
x <- as.matrix(ath)
plot2d <- function(col=3)
{
  plot (x, asp = 0, col = col, pch = 19, cex = 2, 
        xlab="Height (m)", 
        ylab="Weight (kg)", 
        main="Curlers at Sochi 2014 Winter Olympics")
}
png('pca2-scatterplot.png')
plot2d()
dev.off()

# Perform PCA
pcX <- prcomp(x, retx = TRUE, scale = FALSE, center=TRUE)

# Transform points
transformed  <- pcX$x [,1] %*% t (pcX$rotation [1,])
transformed <- scale (transformed, center = -pcX$center, scale = FALSE)

# Plot PCA projection
plot_pca <- function()
{
  plot2d()
  points (transformed, col = 2, pch = 15, cex = 2)
  segments (x [,1],x [,2], transformed [,1], transformed [,2])
}
png('pca3-pca-projection.png')
plot_pca()
dev.off()

# Draw first principal component over scatterplot
png('pca4-first-component-on-scatterplot.png')
plot_pca()
lm.fit <- lm(transformed[,2] ~ transformed[,1])
abline(lm.fit, col="blue", cex=1.5)
dev.off()

# Plot first principal component by itself
png('pca5-first-component-stripchart.png')
stripchart(pcX$x[,1], col="red", cex=2, pch=15, 
           xlab="First principal component")
dev.off()
