
#' try to locate some usual locations for rClr source
#' 
#' try to locate some usual locations for rClr source
#' 
#' @return the first matching location. 
#' @export
tryFindPkgDir <- function() {
  a <- c(
  'f:/src/codeplex/rclr',
  'f:/codeplex/r2clr/packages/rClr',
  'c:/src/codeplex/rclr',
  'c:/src/codeplex/r2clr/packages/rClr')
  m <- file.exists(a)
  if(!any(m)) {stop('no usual location for rClr found')}
  a[m][1]
}

#' Copy the debug binaries of rClr to the installed package.
#' 
#' Copy the debug binaries of rClr to the installed package. Reconsider using devtools load_all for development, but I had issues getting it to work with rClr.
#' 
#' @param pkgDir root of the rClr package source
#' @param rlib optional path to where the rClr binary package is installed.
#' @export
cpDebugBins <- function(pkgDir= tryFindPkgDir(), rlib=NULL) {

  rclrsrc = file.path(pkgDir, 'src')
  stopifnot(file.exists(rclrsrc)) 

  if(is.null(rlib)) {
    rlib=.libPaths()[1]
  }
  rclrdir <- file.path(rlib,'rClr')
  rclrlibs <- file.path(rclrdir,'libs')
  rclrtests <- file.path(rclrdir,'tests')

  if(!file.exists(rclrdir)) {stop(paste('rClr package not found under', rclrdir))}

  fcopy <- function(dirPath, pattern, toDir) {
  file.copy(
    from=list.files(dirPath, pattern=pattern, full.names=TRUE), 
    to= toDir,
    overwrite= TRUE,
    recursive= FALSE,
    copy.mode=FALSE)
  }

  fcopy(file.path(rclrsrc, 'Debug'), 'rClrMs*', file.path(rclrlibs,'i386')) 
  fcopy(file.path(rclrsrc, 'MonoInstallDebug'), 'rClrMono*', file.path(rclrlibs,'i386')) 
  fcopy(file.path(rclrsrc, 'x64', 'Debug'), 'rClrMs', file.path(rclrlibs,'x64')) 
  fcopy(file.path(rclrsrc, 'Debug'), 'RDotNet.*|ClrFacade.*', rclrlibs) 
  fcopy(file.path(rclrsrc, '..', 'inst', 'tests'), NULL, rclrtests) 
}

#' @export
#' @import roxygen2
#' @import devtools
roxyRclr <- function(pkgDir= tryFindPkgDir()) {
  stopifnot(file.exists(pkgDir)) 
  # Document with Roxigen and install with devtools.
  document(pkgDir)
}

#' @export
#' @import roxygen2
#' @import devtools
installRclr <- function(pkgDir= tryFindPkgDir()) {
  stopifnot(file.exists(pkgDir)) 
# If this is for a release, maybe you are better off installing from the command line interface. See build\cmd_build_commands.txt
  install(pkgDir)
}

# browseVignettes('knitr')
# browseVignettes('rClr')

# See C:\src\codeplex\r2clr\doc\rclr_documentation.Rmd


#' @export
#' @import knitr
#' @import markdown
#' @import stringr
vignettesRclr <- function(pkgDir= tryFindPkgDir()) {
  stopifnot(file.exists(pkgDir)) 
  docDir <- file.path(pkgDir, 'inst', 'doc')
  stopifnot(file.exists(docDir)) 
  rmd_files <- list.files(docDir, pattern='\\.Rmd$', full.names=TRUE)
  options(markdown.HTML.stylesheet = system.file('misc', 'vignette.css', package='knitr'))
  md_files <- str_replace(rmd_files, pattern='\\.Rmd', '\\.md')
  html_files <- str_replace(rmd_files, pattern='\\.Rmd', '\\.html')
  f <- function() {
    # Wow! if using 'i' funny things happen. Probably the way knit executes the R code in the files. Yikes.
    for (j in 1:length(rmd_files)) {
        knit(rmd_files[j], md_files[j])
        markdownToHTML(md_files[j], html_files[j])
    }
  }
  originalDir <- getwd()
  setwd(docDir)
  f()
  setwd(originalDir)
}

# TODO: presentations
# The presentation should be created with knitr loaded only: so that the output of library(rClr) is captured:
# setwd(file.path(pkgDir, '../..', 'doc/presentations'))
# list.files(pattern='Rnw')
# knit2pdf(input=list.files(pattern='Rnw'))


