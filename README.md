# jmdots-comfyui

**JMDOTS ComfyUI**

A simple container lifecycle management solution for ComfyUI using `docker-compose`.

ComfyUI is a revolutionary node-based graphical user interface (GUI) designed to facilitate the use of [Stable Diffusion](https://stability.ai/), a powerful platform for generating AI-driven images. Unlike traditional text-based interfaces, ComfyUI uses a visual approach where users can create and manage complex workflows through interconnected nodes. This setup allows for greater flexibility, customization, and understanding of each step involved in the image generation process.

For more information, refer to the [Beginner's Guide to ComfyUI](https://stablediffusionweb.com/blog/beginners-guide-to-comfyui) and the [Definitive Guide to ComfyUI](https://openaijourney.com/comfyui-guide).

## Features

- [x] Support `make` managing the container lifecycle.
- [x] Provide a Dockerfile for NVIDIA GPUs based on the [NVIDIA PyTorch image](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch).
- [x] Support ComfyUI Manager first-install as well as existing installations already present in a host directory.
- [x] Support mounting a host directory containing models as a volume into the container.
  - **Note**: This models directory won't be the one used by ComfyUI Manager.
- [x] Provide a simple default `extra_model_paths.yaml`.
  - **Note**: This file will not address ComfyUI Manager's paths.
- [x] Support mounting a host directory to `ComfyUI/custom_nodes` as a volume into the container.
  - **Note**: This enables persistence for ComfyUI Manager.
- [x] Bind the container's port to the host's localhost for security.
- [x] Support [Docker CE](https://www.docker.com/products/docker-desktop) container manager.
- [x] Delegate to ComfyUI Manager all of the hard things like managing models, custom nodes, etc.
- [x] Reach the point of zero warnings seen on container boot.

## Roadmap

- [ ] Implement GitHub Actions CI for building images that push to [Docker Hub](https://hub.docker.com).
- [ ] Provide a pre-built Docker image that supports NVIDIA GPUs.
- [ ] Support running ComfyUI across multiple NVIDIA GPUs present on the host.
- [ ] Support [Podman](https://podman.io/) container manager.
- [ ] Support `podman-compose` managing the container lifecycle.
- [ ] Support AMD GPUs.
- [ ] Support Kubernetes managing the container lifecycle.

## Prerequisites

- [Docker CE](https://www.docker.com/products/docker-desktop) installed on your host machine.
- [NVIDIA GPU drivers](https://developer.nvidia.com/cuda-downloads) and [NVIDIA Docker support](https://github.com/NVIDIA/nvidia-docker) if you plan to use NVIDIA GPUs.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/jmdots/jmdots-comfyui.git
    cd jmdots-comfyui
    ```

2. Build and start the Docker containers:
    ```bash
    make rebuild
    ```

## Interfaces

### `make`

- `make build`: Build or rebuild container images
- `make up`: Create and start enabled containers
- `make down`: Stop and remove enabled containers, networks
- `make restart`: Restart enabled containers
- `make rebuild`: Rebuild container images and restart enabled containers
- `make stop`: Stop services
- `make logs`: Watch output from enabled containers
- `make nvidia`: Watch NVIDIA GPU usage
- `make ps`: List enabled containers
- `make rm`: Remove stopped service containers
- `make shell`: Get a shell prompt in the running container
- `make manager`: Clone or update ComfyUI-Manager

## Usage Examples

- To check the logs of the running containers:
    ```bash
    make logs
    ```

- To access a shell in the running container:
    ```bash
    make shell
    ```

- To monitor NVIDIA GPU usage:
    ```bash
    make nvidia
    ```

## Deployment Contexts

This project has been successfully deployed and tested in the following contexts:

| **Operating System**       | **CPU**   | **GPU**                | **Memory** |
|----------------------------|-----------|------------------------|------------|
| Ubuntu 22.04.4 LTS (amd64) | AMD 7700X | NVIDIA RTX 4090 (24GB) | 128GB DDR5 |

## Development

To contribute to this project, follow these steps:

1. Fork the repository.
2. Clone your fork:
    ```bash
    git clone https://github.com/<your-username>/jmdots-comfyui.git
    cd jmdots-comfyui
    ```
3. Create a new branch for your feature or bugfix:
    ```bash
    git checkout -b my-feature-branch
    ```
4. Make your changes and commit them:
    ```bash
    git commit -m "Description of my changes"
    ```
5. Push your changes to your fork:
    ```bash
    git push origin my-feature-branch
    ```
6. Open a pull request to the main repository.

## Continuous Integration (CI)

**Note**: This feature is not yet active.

This project uses GitHub Actions for CI. The workflow is set up to build and push the Docker image to Docker Hub whenever a new tag is pushed.

### Setting Up GitHub Secrets

To securely handle your Docker Hub credentials, add them as secrets in your GitHub repository settings:

1. Go to your GitHub repository.
2. Navigate to **Settings** > **Secrets** > **New repository secret**.
3. Add two secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your improvements. Please ensure you understand the license sections below before contributing. Thank you!

## License

This project includes components licensed under the GNU General Public License (GPL) version 3.0:

- [ComfyUI](https://github.com/comfyanonymous/ComfyUI/blob/master/LICENSE)
- [ComfyUI Manager](https://github.com/ltdrdata/ComfyUI-Manager/blob/main/LICENSE.txt)

```
========================
jmdots-comfyui by JMDOTS
========================
Copyright © 2024 Joshua M. Dotson (contact@jmdots.com)

JMDOTS-DUAL-LICENSE-1.2
=======================
https://legal.jmdots.com/licenses/

Personal, Non-Commercial License
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
This software is provided under the GNU Affero General Public License (AGPL)
version 3 or later. You are free to use, modify, and distribute this
software for personal, non-commercial use under the terms of the AGPL. If you
modify this software and distribute it, you must also make the modified
source code available under the same license terms. There is no warranty for
this software, to the extent permitted by applicable law.

For more details, please refer to the full text of the GNU AGPL: [GNU Affero
General Public License](http://www.gnu.org/licenses/)

Commercial License
~~~~~~~~~~~~~~~~~~
This software is available under a Commercial License for any business,
commercial, enterprise, or governmental use. The Commercial License allows
you to use, modify, and distribute this software in proprietary applications
without the requirement to disclose source code modifications or derivative
works. Under this license, you receive additional support and maintenance
services.

For information on purchasing a commercial license, please contact us at
[sales@jmdots.com](mailto:sales@jmdots.com) or visit our website at [JMDOTS
GitHub](http://www.github.com/jmdots/).

Limited Liability
~~~~~~~~~~~~~~~~~
In no event shall the authors or copyright holders be liable for any claim,
damages, or other liability arising from the use or distribution of this
software.
```
