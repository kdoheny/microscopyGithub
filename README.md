# microscopyGithub

Workflow for leica microscopy system.

Specifically, takes in data and image files from wing imaging pipeline and creates new files such that the wings4 program (Houle et al 2003) may be run.

Functions in this package 
1) xmlTiffMatcher check for corresponding tif and metadata files, 
2) metaDataExtractor extract metadata from xml and xlif files that do have corresponding tif, 
3) metadataLandmarkCombine combines landmark data produced using tpsDigs with extracted metadata to produce a file that can be used by Wings4
