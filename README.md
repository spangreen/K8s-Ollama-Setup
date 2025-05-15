
# 📘 Secure Ollama on Kubernetes with API Key Authentication

## 📁 Repository Structure

```bash
ollama-secure-k8s/
├── manifests/
│   ├── namespace.yaml
│   ├── nvidia-operator.yaml           # Helm-based install (documented)
│   ├── ollama-deployment.yaml
│   ├── nginx-proxy-configmap.yaml
│   ├── nginx-proxy-deployment.yaml
│   ├── nginx-proxy-service.yaml
│   ├── ingress-nginx-controller.yaml  # Link to apply directly
│   ├── ollama-ingress.yaml
├── test/
│   ├── aider-test.md
│   └── postman-collection.json
├── README.md
└── .gitignore
```

---

## 🧱 Deployment Order

### 1. Create Namespace

```bash
kubectl apply -f manifests/namespace.yaml
```

---

### 2. Install NVIDIA GPU Operator (manual Helm install)

```bash
helm repo add nvidia https://nvidia.github.io/gpu-operator
helm install --wait gpu-operator nvidia/gpu-operator \
  --namespace ollama --create-namespace
```

> Note: Ensure NVIDIA drivers are installed on the host nodes first.

---

### 3. Deploy Ollama (GPU-enabled)

```bash
kubectl apply -f manifests/ollama-deployment.yaml
```

---

### 4. Deploy API Key Auth Proxy (NGINX)

```bash
kubectl apply -f manifests/nginx-proxy-configmap.yaml
kubectl apply -f manifests/nginx-proxy-deployment.yaml
kubectl apply -f manifests/nginx-proxy-service.yaml
```

---

### 5. Install Ingress-NGINX Controller

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.9.4/deploy/static/provider/cloud/deploy.yaml
```

> Wait for pods in the `ingress-nginx` namespace to become ready.

---

### 6. Create Ingress Resource

```bash
kubectl apply -f manifests/ollama-ingress.yaml
```

---

### 7. Update Local DNS

Edit your `/etc/hosts` file (or internal DNS) and add:

```
<INGRESS_CONTROLLER_IP> ollama.local
```

Example:
```
192.168.49.2 ollama.local
```

---

## 🔐 Authentication via API Key

The proxy uses bearer token authentication. All clients must include:

```http
Authorization: Bearer abc123secret
```

Valid API keys are defined in `nginx-proxy-configmap.yaml` under the `map` block of `nginx.conf`.

---

## 🤖 Aider Setup (Terminal-based Coding Assistant)

```bash
export OLLAMA_API_BASE=http://ollama.local
export OLLAMA_API_KEY=abc123secret
```

Then run:

```bash
aider your_file.py
```

You can see test examples in `test/aider-test.md`.

---

## 🧩 Continue (VSCode Plugin)

1. Install the [Continue extension](https://marketplace.visualstudio.com/items?itemName=Continue.continue)
2. Add this to your VSCode `settings.json`:

```json
"continue.server.endpoint": "http://ollama.local",
"continue.server.headers": {
  "Authorization": "Bearer abc123secret"
}
```

3. Trigger Continue from the command palette or inline suggestion tools.

---

## 🧪 Postman Test Setup

1. Open Postman and import `test/postman-collection.json`
2. Set up environment:

```json
{
  "base_url": "http://ollama.local",
  "api_key": "abc123secret"
}
```

3. Run the included test case: `Generate Response`

---

## ✅ Summary

| Component            | Secured?     | GPU Enabled? | Public Access? |
|---------------------|--------------|--------------|----------------|
| Ollama              | ✅ via proxy | ✅           | ✅ via ingress |
| NGINX Auth Proxy    | ✅ API key   | N/A          | Internal only  |
| Ingress-NGINX       | No           | N/A          | ✅             |

---

## 🔄 Next Steps

- [ ] Optional: Convert to Helm chart with configurable values
- [ ] Add TLS via cert-manager
- [ ] Create token management service or dynamic access control
