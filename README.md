# Docker file to run StyleGAN2 ADA, docker-stylegan2-ada
* Licensed under the MIT license
* GitHub: https://github.com/jeffheaton/docker-stylegan2-ada
* DockerHub: https://hub.docker.com/r/heatonresearch/stylegan2-ada

[Jeff Heaton's](http://www.heatonresearch.com) Docker image for running Stylegan2 ADA with GPU. This dockerfile is intended to be run from [NVIDIA Docker](https://github.com/NVIDIA/nvidia-docker). To start a container from this image run something similar to the following:

```
nvidia-docker run -it -u $(id -u):$(id -g) -v /home/username/:/mnt --device /dev/nvidia0:/dev/nvidia0 --device /dev/nvidiactl:/dev/nvidiactl --device /dev/nvidia-uvm:/dev/nvidia-uvm heatonresearch/stylegan2-ada /bin/bash
```

The above command establishes the following:

* **-u $(id -u):$(id -g)** - This causes the user to be logged into Docker to be the same as the user running the Docker command.  This ensures that all permissions and ownerships are correct on the mounted volumes.
* **/home/username/:/mnt** - You should mount a volume to access your images and store results to.
* **/bin/bash** - We start the BASH shell to allow you to execute commands.

# Convert Image Data

Your images must be converted to TFRecords. It is very important that all of your images be of the same size, be square, and of the same color depth. You cannot mix color and greyscale images.  The following command converts a data set named "fish".  The source JPEGs should be in the /mnt/data/fish and the resulting TFRecords will be written to /mnt/datasets/fish.

```
cd /home/stylegan2-ada/
python dataset_tool.py create_from_images /mnt/datasets/fish /mnt/data/fish
```

# Train GANs

To actually train your GAN use a command similar to the following.

```
cd /home/stylegan2-ada/
python train.py --gpus=1 --data=/mnt/datasets/fish --mirror=1 --kimg 3000 --outdir=/mnt/results --aug=ada
```

You must provide an input directory that contains your image TFRecords. You must also provide an output results directory.  The results directory will contain snapshots of your generator, sample images as training progresses, and a log.