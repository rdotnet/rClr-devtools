\name{cpDebugBins}
\alias{cpDebugBins}
\title{Copy the debug binaries of rClr to the installed package.}
\usage{
  cpDebugBins(pkgDir = tryFindPkgDir(), rlib = NULL)
}
\arguments{
  \item{pkgDir}{root of the rClr package source}

  \item{rlib}{optional path to where the rClr binary
  package is installed.}
}
\description{
  Copy the debug binaries of rClr to the installed package.
  Reconsider using devtools load_all for development, but I
  had issues getting it to work with rClr.
}

