# docker-comfyui
A simple container Lifecycle for ComfyUI

## Goals

### Short-term Goals

- [ ] Provide a Dockerfile for NVIDIA GPUs.
- [ ] Support ComfyUI Manager first-install as well as existing installations already present in a host directory.
- [ ] Support mounting a host directory containing models as a volume into the container.
  - NOTE: This models directory won't be the one used by ComfyUI Manager.
- [ ] Provide a simple default `extra_model_paths.yaml` 
  - NOTE: This file will not address ComfyUI Manager's paths.
- [ ] Support mounting a host directory to `ComfyUI/custom_nodes` as a volume into the container.
  - NOTE: This enables persistence for ComfyUI Manager.
- [ ] Manage the entire lifecycle of the container using `make`.
- [ ] Give ComfyUI its own Python 3.10 pyenv virtual environment.
  - The version is 3.10 because 3.11 and 3.12 aren't supported well by some projects, yet.
- [ ] Support Docker CE container manager.
- [ ] Delegate to ComfyUI Manager all of the hard things like managing models, custom nodes, etc.
- [ ] Reach the point of zero warnings seen on container boot.


### Future Goals

- [ ] Provide a pre-built Docker image for NVIDIA GPUs.
- [ ] Support Podman container manager.


### Stretch Goals

- [ ] Provide a Dockerfile for AMD GPUs.
- [ ] Provide a pre-built Docker image for AMD GPUs.	


## Interfaces

### `make`

```
make build       Build or rebuild container images
make up          Create and start enabled containers
make restart     Restart enabled containers
make rebuild     Rebuild container images and restart enabled containers
make down        Stop and remove enabled containers, networks

make kill        Force stop enabled containers
make logs        Watch output from enabled containers
make nvidia      Watch nvidia-smi
make ps          List enabled containers
make rm          Removes stopped service containers
make shell       Get a shell prompt in the running container
make stop        Stop services
```
