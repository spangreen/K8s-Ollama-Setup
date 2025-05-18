# Helm-based install recommended (not raw YAML):
# Command:
#   helm repo add nvidia https://nvidia.github.io/gpu-operator
helm install --wait gpu-operator nvidia/gpu-operator --namespace ollama --create-namespace
