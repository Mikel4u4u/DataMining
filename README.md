# Метрические алгоритмы классификации

Метрический алгоритм - алгоритм классификации основанный на оценке близости объектов, используя функцию расстояния. 

При этом метрические алгоритмы основываются на гипотезе компактности, которая говорит, что схожим объектам соответствуют схожие ответы.

Метрические методы обучения - методы, основанные на анализе сходства объектов.

 Метрический алгоритм классификации с обучающей выборкой ![](https://latex.codecogs.com/gif.latex?X^l)  относит объект u к тому классу y, для которого суммарный вес ближайших обучающих объектов ![](https://latex.codecogs.com/gif.latex?W_y(u,X^l)) максимален:
 
![](https://latex.codecogs.com/gif.latex?a(u;X^l)=arg&space;\max_{y\epsilon&space;Y}W_y(u,X^l)),
где весовая функция ![](https://latex.codecogs.com/gif.latex?\omega&space;(i,u)) оценивает степерь важности i-го соседа классификации объекта u.

Функция ![](https://latex.codecogs.com/gif.latex?W_y(u,X^l)) - наз оценкой близости *u* к классу *y*.

Алгоритм k ближайших соседей (kNN)
---------------- 
 
Алгоритм k ближайших соседей - **kNN** отоносит объект *u* к тому классу элементов, которого больше среди k ближайших соседей ![](https://latex.codecogs.com/gif.latex?x_u).

Мы используем выборку Ирисов Фишера (iris), содержащий 150 объектов разделенный на три класса по 50 элементов: setosa , versicolour и virginica. Каждый класс представлен четырьмя признаками: «Sepal.Length» (длина чашелистика), «Sepal.Width» (ширина чашелистика), «Petal.Length» (длина лепестка) и «Petal.Width» (ширина лепестка).

Алгоритм выглядит следующим образом:

1. Вычисляем евклидово расстояние от классфицируемого объекта до элементов выборки.

```diff
euclideanDistance <- function(u, v) {
  sqrt(sum((u - v)^2)) }
```

2. Сортируем расстояния в порядке возрастания и выбираем первые k элементов.
```diff
sortObjectsByDist <- function(xl, z, metricFunction = euclideanDistance) { # Сортируем объекты согласно расстояния до объекта z
 l <- dim(xl)[1]
 n <- dim(xl)[2] - 1
 
 distances <- matrix(NA, l, 2)                                             # Создаём матрицу расстояний
 for (i in 1:l)  {
 distances[i, ] <- c(i, metricFunction(xl[i, 1:n], z))
 }
 orderedXl <- xl[order(distances[, 2]), ]                                  # Сортируем
 return (orderedXl);
```

3. Выбираем наиболее часто встречающийся класс среди k ближайших соседей.

```diff
kNN <- function(xl, z, k)  { 
 orderedXl <- sortObjectsByDist(xl, z)      # Сортируем выборку согласно классифицируемого объекта
 n <- dim(orderedXl)[2] - 1
 classes <- orderedXl[1:k, n + 1]           # Получаем классы первых k соседей
 counts <- table(classes)                   # Составляем таблицу встречаемости каждого класса
 class <- names(which.max(counts))          # Находим класс, который доминирует среди первых k соседей
 return (class)
}
```




Оптимальное значение параметра k определяют по критерию скользящего контроля с исключением объектов по одному (leave-one-out, LOO):

<img src="http://www.sciweavers.org/tex2img.php?eq=LOO%28%20%5Cmu%20%2C%20X%5El%29%20%3D%201%2Fl%20%20%5Csum_l%5Ei%20Q%28%20%5Cmu%20%28X%5El%2F%7Bx_i%7D%29%2C%7Bx_i%7D%29&bc=White&fc=Black&im=jpg&fs=12&ff=ccfonts,eulervm&edit=0" align="center" border="0" alt="LOO( \mu , X^l) = 1/l  \sum_l^i Q( \mu (X^l/{x_i}),{x_i})" width="275" height="50" />

ПреимуществаLOO в том, что каждый объект ровно один раз участвует в контроле,а длина обучающих подвыборок лишь на единицу меньше длины полной выборки.Недостатком LOO является большая ресурсоёмкость, так как обучаться приходится L раз.

Ниже представлены график зависимости LOO и карта классификафии

![](https://github.com/icyvan/DataMining/blob/master/images/loo_knn.png)
