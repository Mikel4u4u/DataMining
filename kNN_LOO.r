colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue")
plot(NULL, NULL, type = "l", xlim = c(min(iris[, 3]), max(iris[, 3])), ylim = c(min(iris[, 4]), max(iris[, 4])), xlab = 'Petal.Length', ylab = 'Petal.Width')

euclideanDistance <- function(u, v) {         # ��������� ����������          
  sqrt(sum((u - v)^2))
}

sortObjectsByDist <- function(xl, z, metricFunction = euclideanDistance) # ��������� ������� �������� 
{                                                                        # ���������� �� ������� z
  l <- dim(xl)[1] # 150
  n <- dim(xl)[2] - 1 # 2
}


distances <- matrix(NA, l, 2)             # ������� ����������
for(p in 1:l) {
  distances[p, ] <- c(p, euclideanDistance(xl[p, 1:n], point))
}
orderedxl <- xl[order(distances[ , 2]), ] # ��������� ����������
return (orderedXl);

kNN <- function(xl, z, k)               #��������� ����� kNN
{
  orderedXl <- sortObjectsByDist(xl, z) # ��������� ������� �������� ����������������� �������
  n <- dim(orderedXl)[2] - 1
  classes <- orderedxl[1:k, n + 1]    # �������� ����� ������ k �������
  counts <- table(classes)            # ���������� ������� ������������� ������� ������
  classname <- which.max(counts)      # ������� �����, ������� ���������� ����� ������ k �������
  return (class)
}                             


colors <- c("setosa" = "red", "versicolor" = "green3", "virginica" = "blue") # ������ �������
plot(iris[, 3:4], pch = 21, bg = colors[iris$Species], col = colors[iris$Species], asp = 1)

z <- c(2.7, 1)                      # ������������� ������ ��������� �������
xl <- iris[, 3:5]
class <- kNN(xl, z, k=6)
points(z[1], z[2], pch = 22, bg = colors[class], asp = 1)

legend("bottomright", c("virginica", "versicolor", "setosa"), pch = c(15,15,15), col = c("blue", "green3", "red"))


plot(NULL, NULL, type = "l", xlim = c(0, 150), ylim = c(0, 1), xlab = 'k', ylab = 'LOO')
step <- 5
Ox <- seq(from = 1, to = 150, by = step) # k
Oy <- c() # LOO

LOO_opt <- 1                      # ������������� ��������� ��������
k_opt <- 1
for(k in Ox) {
  Q <- 0                          # ������� ������� � ����������� ��� �������� 0
  for(i in 1:l) {
    iris_new <- iris[-i, ]        # ����� ������� ��� X_i ��������
    point <- iris[i, 3:4]
    if(knn(iris_new, point, k) != iris[i, 5]) {  # ���� ��������� ������,
      Q <- Q + 1                                 # �� ����������� ������� �� �������
    } 
  }
  LOO <- Q/l
  Oy <- c(Oy, LOO)
  
  if(LOO < LOO_opt) {           
    LOO_opt <- LOO
    k_opt <- k
  }
}

print(Ox)
print(Oy)
print(k_opt)

lines(Ox, Oy, pch = 8, bg = "black", col = "blue")
points(k_opt, LOO_opt, pch = 21, bg = "black", col = "black")