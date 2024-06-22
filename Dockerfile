# Use an official NVIDIA PyTorch runtime as a parent image
FROM nvcr.io/nvidia/pytorch:24.05-py3

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Set the working directory in the container
WORKDIR /workspace

# Update and install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
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
    gnupg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install pip and upgrade
RUN pip install --upgrade pip --root-user-action=ignore

# Clone the ComfyUI repository
RUN git clone https://github.com/comfyanonymous/ComfyUI.git

# Create mount points after cloning
RUN mkdir -p /workspace/models /workspace/ComfyUI/custom_nodes

# Install Python dependencies
RUN pip install --no-cache-dir -r ComfyUI/requirements.txt --root-user-action=ignore

# Expose the port ComfyUI runs on
EXPOSE 8188

# Run ComfyUI
CMD ["python", "ComfyUI/main.py"]
