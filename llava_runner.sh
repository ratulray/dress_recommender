#!/usr/bin/bash

# Define the directory containing the images
IMG_DIR=/home/ec2-user/SageMaker/dresses/

start=0

# Loop through each image in the directory
for img in "${IMG_DIR}"*.png; do
    # Extract the base name of the image without extension
    base_name=$(basename "$img" .png)

    # Define the output file name based on the image name
    output_file="${IMG_DIR}${base_name}.txt"
    if [ $start -ge 1000 ]; then
        break
    fi

    start=$(($start+1))
    if [ $(($start % 10)) -eq 0 ];then
        echo $start
    fi

    # Execute the command and save the output to the defined output file
    # echo $output_file
    /home/ec2-user/SageMaker/llama.cpp/build/bin/llava-cli -m /home/ec2-user/SageMaker/llava/ggml-model-q4_k.gguf \
    --mmproj /home/ec2-user/SageMaker/llava/mmproj-model-f16.gguf -ngl 1 --temp 0.1 \
    -p "Describe the apparels present in the image in detail. Mention in which situations the dress can be worn." --image "$img" > "$output_file"

done
