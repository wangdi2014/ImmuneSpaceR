
# Source depdencies -------------------------------------------
source("global_variable.R")
source("global_dependencies.R")
source("set_curlOptions.R")

# Connections --------------------------------------------------
sdy269 <- CreateConnection("SDY269")

# Helper Functions ---------------------------------------------
testQP <- function(con, dataset, ...){
  res <- tryCatch(con$quick_plot(dataset, ...),
                  error = function(e) return(e)
                  )
}


# Tests --------------------------------------------------------
context("quickPlot")

# ---- Default Args for Reference ----------
# normalize_to_baseline = TRUE,
# type = "auto",
# filter = NULL,
# facet = "grid",
# text_size = 15,
# legend = NULL,
# show_virus_strain = FALSE,
# interactive = FALSE

test_that("default arguments", {
  res <- testQP(con = sdy269, 
                dataset = "hai")
  expect_true( !is.null(res$plot) )
})

test_that("normalize to baseline = FALSE", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                normalize_to_baseline = FALSE)
  expect_true( !is.null(res$plot) )
})

test_that("type changes", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                type = "violin")
  expect_true( !is.null(res$plot) )
})

# filter must be in Rlabkey's format
test_that("non-null filter", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                filter = Rlabkey::makeFilter(c("study_time_collected", "EQUALS", "28")) )
  expect_true( !is.null(res$plot) )
})

# facet styles allowed grid, wrap
test_that("non-grid facet", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                facet = "wrap")
  expect_true( !is.null(res$plot) )
})

test_that("alternative text-sizes", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                text_size = 20)
  expect_true( !is.null(res$plot) )
})

# When there is no error, it comes back NULL
test_that("non-null legend", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                type = "heatmap", # must be heatmap for legend to be used
                legend = "Race") # Race, Gender, Age are possible
  expect_true( is.null(res) )
})

test_that("show_virus_strain = TRUE", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                show_virus_strain = TRUE)
  expect_true( !is.null(res$plot) )
})

test_that("interactive = TRUE", {
  res <- testQP(con = sdy269, 
                dataset = "hai",
                interactive = TRUE)
  expect_true( !is.null(res$x) ) # note: diff named list
})

# cleanup ------------------------------------------------------
if(exists("netrc_file")){
  file.remove(netrc_file)
}


