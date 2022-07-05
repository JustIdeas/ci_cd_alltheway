#!/bin/bash
fileid="10i7eYkkL_OuWuHcrtRGxdvfdiVjBjdJ6"
filename="jenkins_home.tar.zst"
html=`curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}"`
curl -Lb ./cookie "https://drive.google.com/uc?export=download&`echo ${html}|grep -Po '(confirm=[a-zA-Z0-9\-_]+)'`&id=${fileid}" -o ${filename}

