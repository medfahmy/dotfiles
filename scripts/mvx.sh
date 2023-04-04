#!/bin/bash

#print the list of all text files
ls *.jpeg

#Iterate the loop to read all text files
for value in `ls *.jpeg`;
do
    #Read the basename of the file
    filename=`basename $value .txt`
    #Rename all files to doc files
    mv $value $filename.doc;
done

#Print all doc files
ls *.doc
