

#' @title Matches .xml files with .tiff files in processing pipeline
#' @description xml and .tiff matcher.
#' Makes sure that every image taken has an associated xml file with scale data.
#' Outputs a list of .xml and xlif files for information extraction.
#' Outputs a vector of .xlif files for information extraction.
#' @param meta character string(1) path to directory of metadatafiles
#' @param tiffLocate character string(1) path to directory of image files
#'
#' @return A list of xml files with matching tifs where xml entries occur before xlif entries.
#' @export
#'
#' @examples
#' meta<-"A:/PhD/HalfSib/D.suzukiiHS/allData/leicametadata"
#' tiflocate<-"C:/Users/sztfl/sztfl/Imaging/suzukii_binom_mc_feb2022_block1/"
xmlTiffMatcher <- function(meta, tiffLocate) {
  #list of all metadata files with xml or xlif extension
  xlifVec <- list.files(path = meta, pattern = ".xlif")
  xmlVec <- list.files(path = meta, pattern = ".xml")
  imageVec <- list.files(path = tifLocate, pattern = ".tif")

  imgVecPre <-
    unlist(strsplit(sapply(imageVec, as.character), split =  '.tif'))
  xmlVecPre <-
    unlist(strsplit(sapply(xmlVec, as.character), split =  '.xml'))
  xlifVecPre <-
    unlist(strsplit(sapply(xlifVec, as.character), split =  '.xlif'))

  if (length(setdiff(xmlVecPre, imgVecPre)) == 0 ||
      length(setdiff(xlifVecPre, imgVecPre)) == 0) {
    difXlif <- setdiff(xlifVecPre, imgVecPre)
    difXml <- setdiff(xmlVecPre, imgVecPre)
    print(c(difXml, difXlif))
    print(
      "Check these files for errors because the images dont match the xml/xlif, fix, and try again."
    )
    ##delete
    l <- list("xlif" = xlifVec, "xml" = xmlVec)
    return(l)
  } else{
    l <- list("xlif" = xlifVec, "xml" = xmlVec)
    return(l)
  }
}
#matchedXml<-xmlTiffMatcher(meta,tiffLocate)

