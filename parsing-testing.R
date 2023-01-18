f <- function(data, ...){
  dots = rlang::enquos(...)
  # check
  dots
}


# iris, x = species, y = petal, group = Species

f(data, x = species, y = petal, group = Species)

# make_datasets?

f <- function(data, ...){

  dots = rlang::enquos(...)

  data_selected <- dplyr::select(data, !!!dots)

  if ('group' %in% names(dots)) {
    data_selected <-
      dplyr::group_split(data_selected, group)
  }

  datasets <-
    lapply(data_selected, function(group_data){
      list(
        label = group_data$group[1],
        data = apply(group_data[1:5, c('x', 'y')], 1, as.list)
      )
    })

}


# iris, x = species, y = petal, group = Species

f(iris, x = Sepal.Width, y = Sepal.Length, group = Species)

zz[[1]][1:5,1:2] %>%
  apply(1, as.list) %>%
  jsonlite::toJSON(auto_unbox = T)

