#! /bin/bash

# Removing noise and less informative words from files in a directory

# OBS: Directory with documents 
# should be put in the same dir of the script

# Directory with clean documents
mydir='corpus'
mkdir -p $mydir;

cd 'corpus1k-noisy';
for file in *
do
    perl -pe 's/[^a-zA-Z\s]/ /g;' $file > ../$mydir/$file; 
done;
