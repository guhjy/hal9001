context("feed single lambda into hal9001 (glmnet version) will not error.")

set.seed(1234)
expit <- function(x) exp(x) / (1 + exp(x))
n <- 1e3
x <- rnorm(n)
y <- as.numeric(expit(2 * x + rnorm(n)) > .5)
wgt <- rep(1, n)

hal_fit <- fit_hal(
  X = x,
  Y = y,
  weights = wgt,
  use_min = TRUE,
  yolo = FALSE,
  fit_type = "glmnet",
  family = "binomial",
  lambda = 2e-2,
  return_lasso = TRUE
)

test_that("a single glmnet object is output", {
  expect("glmnet" %in% class(hal_fit$glmnet_lasso))
})
test_that("cv.glmnet object is not output", {
  expect(is.null(hal_fit$hal_lasso))
})

yhat <- predict(hal_fit, new_data = x)
# plot(expit(yhat) ~ x, ylim = c(0, 1))
