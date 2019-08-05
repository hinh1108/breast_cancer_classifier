#!/bin/bash

cd /Users/hinhct/work/cdha/Birads-detection/breast_cancer_classifier

DEVICE_TYPE='gpu'
NUM_EPOCHS=10
HEATMAP_BATCH_SIZE=100
GPU_NUMBER=0

PATCH_MODEL_PATH='models/sample_patch_model.p'
IMAGE_MODEL_PATH='models/ImageOnly__ModeImage_weights.p'
IMAGEHEATMAPS_MODEL_PATH='models/ImageHeatmaps__ModeImage_weights.p'

SAMPLE_SINGLE_OUTPUT_PATH='sample_single_output'
export PYTHONPATH=$(pwd):$PYTHONPATH
ENABLE_DELETE="-ed"

#echo 'Stage 1: Crop Mammograms'
python3 src/cropping/crop_single.py \
    --mammogram-path $1 \
    --view "R-CC" \
    --cropped-mammogram-path ${SAMPLE_SINGLE_OUTPUT_PATH}/$3\
    --metadata-path ${SAMPLE_SINGLE_OUTPUT_PATH}/cropped_metadata.pkl

OUT_PATH=$(pwd)/${SAMPLE_SINGLE_OUTPUT_PATH}/$3/

cd /Users/hinhct/work/cdha/Birads-detection/BIRADS_classifier

python birads_prediction_tf.py --image-path $OUT_PATH

#check enable delete output folder
if [ "$ENABLE_DELETE" =  "$4" ]
then
  rm -rf $OUT_PATH
fi