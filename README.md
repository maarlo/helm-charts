# Helm Charts

## Available Charts

| Chart | Description | Version | App Version |
| ----- | ----------- | ------- | ----------- |

## Quick Start

### Prerequisites

- Kubernetes 1.24+
- Helm 4.0.0+ (some charts may work with lower versions, but no guarantee can be made here)
- PV provisioner support in the underlying infrastructure (if persistence is enabled)

### Installing Charts

```bash
# From GitHub Container Registry (GHCR)
helm install my-release oci://ghcr.io/maarlo/helm-charts/<chartname>

# From local clone
helm install my-release ./charts/<chart-name>
```

## Configuration

Each chart provides extensive configuration options through `values.yaml`.

Refer to individual chart READMEs for detailed configuration options.
