#' @title Combines metadata and landmark files produced by tpsDig
#' @description Combines metadata and landmark files produced by tpsDig and outputs into .csv and .asc formats.
#' @param metaData list of extracted metadata files
#' @param tpsFileName character string (1) name of tps file (no suffix)
#' @param dir character string (1) path to directory where tps file exists
#' @param outputFileName character string (1) output file name (no suffix)
#'
#' @return .asc and .csv datafiles with landmarks coded for the Wings4 program
#' @export
#' @import geomorph
#' @examples
#' tpsFileName<-"asc5.TPS"
#' outputFileName<-"ForWings"
#' dir<-"A:/Github/microscopyGithub/test2"
#' metadataLandmarkCombine(metaData, tpsFile,dir,outputFileName)

metadataLandmarkCombine <- function(metaData, tpsFileName,dir,outputFileName){
  #df1<-read.csv(file.path(dir,metaData))
  df2<-readland.tps(file.path(dir,tpsFile),specID = "imageID",warnmsg = FALSE)

  m1<-matrix(df2[1,,],ncol = 2,byrow = TRUE)
  m2<-matrix(df2[2,,],ncol = 2,byrow = TRUE)

  xyCoord<-cbind(m1,m2)
  xyCoord[,c(2,4)]<-1920-xyCoord[,c(2,4)]
  colnames(xyCoord)<-c("x1","y1","x2","y2")

  combined<-cbind(tiffName=metaData[,1],xyCoord,metaData[,2:ncol(metaData)])
  forAsc<-cbind(combined,ph1=rep(1,nrow(metaData)),ph2=rep(1,nrow(metaData)))

  write.csv(forAsc,file.path(dir,paste0(outputFileName,".csv")),row.names = F)
  write.table(forAsc,file.path(dir,paste0(outputFileName,".asc")),row.names = F,quote = F,col.names = F,sep = " ")
  return(forAsc)
}
#metadataLandmarkCom<-metadataLandmarkCombine(metaData, tpsFile,dir,outputFileName)


