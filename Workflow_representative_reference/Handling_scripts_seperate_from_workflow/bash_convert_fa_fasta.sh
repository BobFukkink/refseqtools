#!/usr/bin/env bash

dirName="/accuracy/*.fa"

for fileName in ${dirName}
do
    awk '/^>/ {printf("\n%s\n",$0);next; } { printf("%s",$0);}  END {printf("\n");}' < ${fileName} > "${fileName}sta"
done
