# docker-comfyui
A simple container lifecycle management solution for ComfyUI.

ComfyUI is a revolutionary node-based graphical user interface (GUI) designed to facilitate the use of [Stable Diffusion](https://stability.ai/), a powerful platform for generating AI-driven images. Unlike traditional text-based interfaces, ComfyUI uses a visual approach where users can create and manage complex workflows through interconnected nodes. This setup allows for greater flexibility, customization, and understanding of each step involved in the image generation process.

For more information, refer to the [Beginner's Guide to ComfyUI](https://stablediffusionweb.com/blog/beginners-guide-to-comfyui) and the [Definitive Guide to ComfyUI](https://openaijourney.com/comfyui-guide).

## Goals

### Short-term Goals

- [x] Provide a Dockerfile for NVIDIA GPUs based on the [NVIDIA PyTorch image](https://catalog.ngc.nvidia.com/orgs/nvidia/containers/pytorch).
- [x] Support ComfyUI Manager first-install as well as existing installations already present in a host directory.
- [x] Support mounting a host directory containing models as a volume into the container.
  - **Note**: This models directory won't be the one used by ComfyUI Manager.
- [x] Provide a simple default `extra_model_paths.yaml`.
  - **Note**: This file will not address ComfyUI Manager's paths.
- [x] Support mounting a host directory to `ComfyUI/custom_nodes` as a volume into the container.
  - **Note**: This enables persistence for ComfyUI Manager.
- [x] Manage the entire lifecycle of the container using `make`.
- [x] Bind the container's port to the host's localhost for security.
- [x] Support [Docker CE](https://www.docker.com/products/docker-desktop) container manager.
- [x] Delegate to ComfyUI Manager all of the hard things like managing models, custom nodes, etc.
- [x] Reach the point of zero warnings seen on container boot.

### Future Goals

- [ ] Provide a pre-built Docker image that supports NVIDIA GPUs.
- [ ] Support running ComfyUI across multiple NVIDIA GPUs present on the host.
- [ ] Support [Podman](https://podman.io/) container manager.
- [ ] Support AMD GPUs.

## Prerequisites

- [Docker CE](https://www.docker.com/products/docker-desktop) installed on your host machine.
- [NVIDIA GPU drivers](https://developer.nvidia.com/cuda-downloads) and [NVIDIA Docker support](https://github.com/NVIDIA/nvidia-docker) if you plan to use NVIDIA GPUs.

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/jmdots/docker-comfyui.git
    cd docker-comfyui
    ```

2. Build the Docker image:
    ```bash
    make build
    ```

3. Start the container:
    ```bash
    make up
    ```

## Interfaces

### `make`

- `make build`: Build or rebuild container images
- `make up`: Create and start enabled containers
- `make restart`: Restart enabled containers
- `make rebuild`: Rebuild container images and restart enabled containers
- `make down`: Stop and remove enabled containers, networks
- `make kill`: Force stop enabled containers
- `make logs`: Watch output from enabled containers
- `make nvidia`: Watch nvidia-smi
- `make ps`: List enabled containers
- `make rm`: Removes stopped service containers
- `make shell`: Get a shell prompt in the running container
- `make stop`: Stop services

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

## Development

To contribute to this project, follow these steps:

1. Fork the repository.
2. Clone your fork:
    ```bash
    git clone https://github.com/<your-username>/docker-comfyui.git
    cd docker-comfyui
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

This project uses GitHub Actions for CI. The workflow is set up to build and push the Docker image to Docker Hub whenever a new tag is pushed.

### Setting Up GitHub Secrets

To securely handle your Docker Hub credentials, add them as secrets in your GitHub repository settings:

1. Go to your GitHub repository.
2. Navigate to **Settings** > **Secrets** > **New repository secret**.
3. Add two secrets:
   - `DOCKER_USERNAME`: Your Docker Hub username.
   - `DOCKER_PASSWORD`: Your Docker Hub password.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request with your improvements.

## License

This project is licensed under the [AGPLv3 License](https://www.gnu.org/licenses/agpl-3.0.html). See the [LICENSE](LICENSE) file for details.
