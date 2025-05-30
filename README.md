# K8s-Ollama-Setup

## Overview

This repository contains a collection of **experimental Kubernetes configurations** for deploying **local large language models (LLMs)** available on [Ollama](https://ollama.com/). The primary use case is to support **proof-of-concept coding assistants** by exposing an OpenAI-compatible LLM endpoint within a Kubernetes environment.

> **Note:** Most of the included configurations are experimental and untested. Only one specific setup has been validated and is described below.

---

## Tested Configuration: Minimal Ollama Deployment (No GPU)

The following resources have been tested and verified to deploy a basic very small Ollama-based LLM in Kubernetes on an 8GB VM with no GPUs:

### Included Resources

| Resource Name           | Description                                                       |
|-------------------------|-------------------------------------------------------------------|
| `ollama-namespace.yaml` | Creates a dedicated namespace for the Ollama resources             |
| `ollama-config.yaml`    | Defines a ConfigMap with the `Modelfile` and model configuration   |
| `ollama-service.yaml`   | Exposes Ollama as a ClusterIP service                              |
| `ollama-no-gpu.yaml`    | Deploys Ollama without GPU requirements                            |
| `ollama-ingress.yaml`   | Ingress resource to expose the API externally via HTTP on port 80  |

### How It Works

This configuration:
- Deploys a CPU-only Ollama instance into a namespace (`ollama`)
- Uses a `ConfigMap` to define the model to run
- Serves the LLM via Ingress on port 80
- Provides an OpenAI-compatible API endpoint usable by tools such as:
  - [aider](https://github.com/paul-gauthier/aider)
  - [Continue](https://github.com/continuedev/continue)
  - [Hollama](https://github.com/fmaclen/hollama)

---

## Experimental and Untested Resources

The repository also contains additional YAML manifests for:

- GPU-enabled Ollama deployments
- Alternative service and ingress setups
- Other model configurations

These files have **not been tested** and are provided for reference and experimentation only.

---

## Usage

### Prerequisites

- A working Kubernetes cluster (local or remote)
- `kubectl` installed and configured
- An ingress controller (e.g., NGINX, Traefik) set up

### Quick Start

Apply the tested resources in order:

```bash
kubectl apply -f ollama-namespace.yaml
kubectl apply -f ollama-config.yaml
kubectl apply -f ollama-no-gpu.yaml
kubectl apply -f ollama-service.yaml
kubectl apply -f ollama-ingress.yaml
