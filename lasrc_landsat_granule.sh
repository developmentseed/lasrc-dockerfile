#!/bin/bash
id="LC08_L1TP_027039_20190901_20190901_01_RT"

IFS='_'
read -ra ADDR <<< "$id" # str is read into an array as tokens separated by IFS
url=gs://gcp-public-data-landsat/LC08/01/${ADDR[2]:0:3}/${ADDR[2]:3:5}/${id}/
gsutil -m cp -r "$url" /tmp
landsatdir=/tmp/${id}
cd "$landsatdir"
ls
for f in *.TIF
	do gdal_translate -co TILED=NO "%f" "%f"
	done
mtl=${id}_MTL.txt
convert_lpgs_to_espa --mtl "$mtl"
ls

