
# Source depdencies -------------------------------------------
source("global_variable.R")
source("global_dependencies.R")
source("set_curlOptions.R")


# Connections --------------------------------------------------
sdy180 <- CreateConnection("SDY180")


# Tests --------------------------------------------------------
context("MBAA Data")

test_that("mbaa query shows correct analyte term", {
  mbaa <- sdy180$getDataset("mbaa")
  analytes <- unique(mbaa$analyte)
  expect_true( sum(grepl("^ANA.+", analytes)) == 0 )
})


# cleanup ------------------------------------------------------
if(exists("netrc_file")){
  file.remove(netrc_file)
}


