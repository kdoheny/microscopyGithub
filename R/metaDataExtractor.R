#takes in list

#' @title Extract meta-data for image files
#' @description Extracts metadata from xlif and xml files that have matching images.
#' @author Kevin Doheny
#' @param whatSeperates n element vector of elements in the imagenames given (eg. 0001_rightwing_kd_rrg c("num","wing","imagerInitials","genotype"))
#' @param matchedXml list object containing xml and xlif files produced by xmlTiffMatcher when run without errors
#'
#' @return
#' @export
#' @import xml2
#' @examples
#' whatSeperates<-c("num","wing","imagerInitials","knf")

metaDataExtractor <- function(whatSeperates,matchedXml){
  numberSplits<-length(whatSeperates)

  orderedIds<-sort(as.character(unlist(matchedXml)))
  suffixRemoved <- unlist(strsplit(orderedIds, ".x"))
  suffixRemoved <- suffixRemoved[c(TRUE, FALSE)]
  dash<-strsplit(suffixRemoved,"_")
  filePaths <- file.path(meta,orderedIds)

  df<-data.frame(matrix(nrow = length(dash),ncol = numberSplits))
  for (i in 1:numberSplits){
    df[,i]<- sapply(dash, "[",i)
  }
  colnames(df)<-whatSeperates

  time<-as.character(file.info(filePaths,extra_cols = F)$mtime)
  t2<-strsplit(time,split = " ")
  dateTime<-matrix(unlist(t2),ncol=2,byrow=T)
  colnames(dateTime)<-c("Date","Time")

  xmlSet<-lapply(filePaths,read_xml)
  dimension<-lapply(xmlSet,xml_find_all,".//Dimensions")
  child<-lapply(dimension,xml_child,1)
  attrs <-lapply(child, xml_attrs)
  realNum<-as.numeric(sapply(attrs, "[", 4))

  for (i in 1:length(realNum)){
    if (realNum[i] > 1){
      realNum[i]<-realNum[i]/2560000
    }else{
      realNum[i]<-realNum[i]/2.56
    }
  }

  dat<-cbind(df,dateTime,Scale=realNum)

  #write.csv(dat,file.path(dir,"preCoord.csv"),row.names = FALSE)
  return(dat)
}
# metaData<-metaDataExtractor(whatSeperates,matchedXml)


