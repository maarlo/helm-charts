# Helm Charts

## Available Charts

| Chart                                                                          | Description                                    | Version                                                                                                                                                                        | App Version                                                                                                                                                                           |
| ------------------------------------------------------------------------------ | ---------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| [Leantime](https://github.com/maarlo/helm-charts/tree/master/charts/leantime/) | Project management for the non-project manager | ![Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/maarlo/helm-charts/master/charts/leantime/Chart.yaml&label=&query=version&prefix=v) | ![App Version](https://img.shields.io/badge/dynamic/yaml?url=https://raw.githubusercontent.com/maarlo/helm-charts/master/charts/leantime/Chart.yaml&label=&query=appVersion&prefix=v) |

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
