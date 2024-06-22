# Use the latest Ubuntu 22.04 as a parent image
FROM ubuntu:22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
ENV CUDA_HOME=/usr/local/cuda-12.5
ENV PATH=$CUDA_HOME/bin:$PATH
ENV LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
ENV PIP_OPTS="--no-cache-dir --root-user-action=ignore --no-build-isolation"

# Set the working directory in the container
WORKDIR /workspace

# Update and install necessary packages including gnupg
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gnupg \
    gnupg2 \
    gnupg1 \
    git \
    curl \
    wget \
    vim \
    ca-certificates \
    libglib2.0-0 \
    libsm6 \
    libxext6 \
    libxrender1 \
    libfontconfig1 \
    libgomp1 \
    python3-pip \
    python3-dev \
    build-essential \
    ninja-build && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add the CUDA repository GPG key
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/3bf863cc.pub

# Add the CUDA repository
RUN echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64 /" > /etc/apt/sources.list.d/cuda.list

# Install CUDA Toolkit 12.5
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    cuda-toolkit-12-5 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pip and upgrade
RUN pip install --upgrade pip

# Carefully install ninja and torch
# Reference: https://github.com/Dao-AILab/flash-attention?tab=readme-ov-file#installation-and-features
RUN pip uninstall -y ninja && pip install ninja torch $PIP_OPTS

# Install FlashAttention requirements
RUN pip install packaging $PIP_OPTS

# Install FlashAttention
RUN pip uninstall -y flash-attn && pip install flash-attn $PIP_OPTS

# Install PyTorch and CUDA (adapt this command to install the specific versions you need)
RUN pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117 $PIP_OPTS

# Install OpenCV
RUN pip install opencv-python $PIP_OPTS

# Clone the ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Create mount points after cloning
RUN mkdir -p /workspace/models /workspace/ComfyUI/custom_nodes

# Install Python dependencies
RUN pip install -r ComfyUI/requirements.txt $PIP_OPTS

# Copy extra_model_paths.yaml to the container
COPY extra_model_paths.yaml /workspace/ComfyUI/extra_model_paths.yaml

# Expose the port ComfyUI runs on
EXPOSE 8188

# Run ComfyUI
CMD ["python3", "ComfyUI/main.py", "--enable-cors-header", "--listen", "0.0.0.0", "--port", "8188", "--extra-model-paths-config", "/workspace/ComfyUI/extra_model_paths.yaml"]
