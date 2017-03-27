#!/bin/bash

perl createsamples.pl info.txt neg.txt ./vecs
python mergevec.py -v vecs/ -o merged.vec

#opencv_createsamples \
#  -vec samples.vec \
#  -info info.txt \
#  -w 25 -h 25 \
#  -num 32

opencv_traincascade -vec merged.vec \
  -data data_new \
  -bg neg.txt \
  -precalcValBufSize 8096 \
  -precalcIdxBufSize 8096 \
  -numPos 150 \
  -numNeg 600 \
  -numStages 15 \
  -featureType LBP \
  -w 30 -h 30 \
  -minHitRate 0.999 \
  -numThreads 4 \
  -maxFalseAlarmRate 0.45
