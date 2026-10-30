# Excalidraw Helm chart

Virtual collaborative whiteboard with a hand-drawn feel. Deploys the frontend (`excalidraw/excalidraw`) and the socket.io server (`excalidraw/excalidraw-room`) with no runtime internet dependency.

## Helm Chart

Installation:

```bash
helm install excalidraw oci://ghcr.io/maarlo/helm-charts/excalidraw
```

## Parameters

### Global parameters

Parameters shared by every component of the chart.

| Name                   | Description                                                                                                                                      | Value |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------ | ----- |
| `global.imageRegistry` | Global container image registry. Overrides every `*.image.registry`. Set it to your internal registry (Harbor, Nexus...) for air-gapped clusters | `""`  |
| `imagePullSecrets`     | Secrets used to pull images from a private registry (list of `{name: <secret>}`)                                                                 | `[]`  |
| `nameOverride`         | String to partially override the release name used in resource names                                                                             | `""`  |
| `fullnameOverride`     | String to fully override the resource names                                                                                                      | `""`  |

### Excalidraw frontend (web) parameters

Static nginx serving the Excalidraw SPA. An initContainer patches the hardcoded collaboration URL before nginx starts.

| Name                                           | Description                                                                               | Value                     |
| ---------------------------------------------- | ----------------------------------------------------------------------------------------- | ------------------------- |
| `web.replicaCount`                             | Number of frontend replicas                                                               | `1`                       |
| `web.image.registry`                           | Frontend image registry                                                                   | `"docker.io"`             |
| `web.image.repository`                         | Frontend image repository                                                                 | `"excalidraw/excalidraw"` |
| `web.image.tag`                                | Frontend image tag. Upstream only publishes `latest`, so pin by digest in production      | `"latest"`                |
| `web.image.digest`                             | Frontend image digest (e.g. `sha256:abcd...`). When set, it takes precedence over the tag | `""`                      |
| `web.image.pullPolicy`                         | Frontend image pull policy                                                                | `"IfNotPresent"`          |
| `web.resources.requests.cpu`                   | Frontend CPU request                                                                      | `"50m"`                   |
| `web.resources.requests.memory`                | Frontend memory request                                                                   | `"64Mi"`                  |
| `web.resources.limits.memory`                  | Frontend memory limit                                                                     | `"256Mi"`                 |
| `web.podAnnotations`                           | Extra annotations for the frontend pods                                                   | `{}`                      |
| `web.nodeSelector`                             | Node labels for frontend pod assignment                                                   | `{}`                      |
| `web.tolerations`                              | Tolerations for frontend pod assignment                                                   | `[]`                      |
| `web.affinity`                                 | Affinity for frontend pod assignment                                                      | `{}`                      |
| `web.podSecurityContext`                       | Pod-level security context for the frontend pods                                          | `{}`                      |
| `web.securityContext.allowPrivilegeEscalation` | Disallow privilege escalation in the frontend containers                                  | `false`                   |
| `web.securityContext.seccompProfile.type`      | Seccomp profile type for the frontend containers                                          | `"RuntimeDefault"`        |

### Collaboration server (room) parameters

excalidraw-room, the socket.io server that relays real-time collaboration messages.

| Name                                            | Description                                                                                                  | Value                          |
| ----------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ------------------------------ |
| `room.replicaCount`                             | Number of room server replicas. Rooms are kept in memory without a shared adapter, so only 0 or 1 is allowed | `1`                            |
| `room.port`                                     | Port the room server listens on (exported to the container as `PORT`)                                        | `3002`                         |
| `room.image.registry`                           | Room image registry                                                                                          | `"docker.io"`                  |
| `room.image.repository`                         | Room image repository                                                                                        | `"excalidraw/excalidraw-room"` |
| `room.image.tag`                                | Room image tag. Upstream only publishes `latest`, so pin by digest in production                             | `"latest"`                     |
| `room.image.digest`                             | Room image digest (e.g. `sha256:abcd...`). When set, it takes precedence over the tag                        | `""`                           |
| `room.image.pullPolicy`                         | Room image pull policy                                                                                       | `"IfNotPresent"`               |
| `room.resources.requests.cpu`                   | Room CPU request                                                                                             | `"50m"`                        |
| `room.resources.requests.memory`                | Room memory request                                                                                          | `"64Mi"`                       |
| `room.resources.limits.memory`                  | Room memory limit                                                                                            | `"256Mi"`                      |
| `room.env`                                      | Extra environment variables for the room container                                                           | `[]`                           |
| `room.podAnnotations`                           | Extra annotations for the room pods                                                                          | `{}`                           |
| `room.nodeSelector`                             | Node labels for room pod assignment                                                                          | `{}`                           |
| `room.tolerations`                              | Tolerations for room pod assignment                                                                          | `[]`                           |
| `room.affinity`                                 | Affinity for room pod assignment                                                                             | `{}`                           |
| `room.podSecurityContext`                       | Pod-level security context for the room pods                                                                 | `{}`                           |
| `room.securityContext.allowPrivilegeEscalation` | Disallow privilege escalation in the room container                                                          | `false`                        |
| `room.securityContext.seccompProfile.type`      | Seccomp profile type for the room container                                                                  | `"RuntimeDefault"`             |

### Collaboration URL patching parameters

The official frontend image hardcodes `https://oss-collab.excalidraw.com` and ignores runtime env vars (upstream issue [excalidraw/excalidraw#5188](https://github.com/excalidraw/excalidraw/issues/5188)). These parameters control the startup rewrite.

| Name                 | Description                                                                                                                                                 | Value |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- | ----- |
| `collab.wsServerUrl` | URL browsers use to reach the room server. Empty means derive it from the ingress (`ingress.room.host`, else `ingress.web.host` with path `/socket.io`)     | `""`  |
| `rewrite.extra`      | Extra literal `from`/`to` string replacements applied to the static files after the mandatory collab rewrite. Use it to neutralise other external endpoints | `[]`  |

### Ingress parameters

HTTPS is required by browsers for live collaboration (WebCrypto needs a secure context).

| Name                         | Description                                                                                                           | Value                  |
| ---------------------------- | --------------------------------------------------------------------------------------------------------------------- | ---------------------- |
| `ingress.enabled`            | Create an Ingress resource                                                                                            | `true`                 |
| `ingress.className`          | IngressClass name                                                                                                     | `"traefik"`            |
| `ingress.scheme`             | Public scheme seen by browsers (`http` or `https`). Keep `https` even if TLS terminates at an external load balancer  | `"https"`              |
| `ingress.tls`                | Enable TLS on the Ingress                                                                                             | `false`                |
| `ingress.annotations`        | Ingress annotations (e.g. proxy timeouts for long-lived WebSocket connections on ingress-nginx)                       | `{}`                   |
| `ingress.web.host`           | Hostname serving the frontend (and the room server when `ingress.room.host` is empty)                                 | `"draw.corp.internal"` |
| `ingress.web.tlsSecretName`  | TLS secret for the web host                                                                                           | `"excalidraw-tls"`     |
| `ingress.room.host`          | Dedicated hostname for the room server. Empty means same host as the frontend with path `/socket.io` (no CORS needed) | `""`                   |
| `ingress.room.tlsSecretName` | TLS secret for the dedicated room host. Defaults to `ingress.web.tlsSecretName`                                       | `""`                   |

### Network policy parameters

Enforces the air gap: pods may only egress to DNS.

| Name                                 | Description                                                                                 | Value                                           |
| ------------------------------------ | ------------------------------------------------------------------------------------------- | ----------------------------------------------- |
| `networkPolicy.enabled`              | Create NetworkPolicies for the frontend and room pods                                       | `false`                                         |
| `networkPolicy.dnsNamespaceSelector` | Labels selecting the namespace running the cluster DNS (egress on port 53 is allowed to it) | `{"kubernetes.io/metadata.name":"kube-system"}` |
| `networkPolicy.ingressFrom`          | Allowed ingress peers (e.g. the ingress controller namespace). Empty allows any source      | `[]`                                            |

## Why the initContainer exists

The official frontend image has `https://oss-collab.excalidraw.com` compiled into its JS and ignores `VITE_APP_WS_SERVER_URL` at runtime (upstream issue [excalidraw/excalidraw#5188](https://github.com/excalidraw/excalidraw/issues/5188)). The chart therefore runs an initContainer that copies the static site to an `emptyDir`, rewrites that URL to your own collab endpoint, and nginx serves the patched copy. No custom image build is required. If the pattern is not found (upstream changed the bundle), the pod **fails loudly** instead of silently collaborating through the public server.

## Routing modes

- **Single host (default):** `/` -> frontend, `/socket.io` -> room. Same origin, no CORS.
- **Dedicated host:** `--set ingress.room.host=draw2gether.corp.internal`.

HTTPS is mandatory: browsers only expose WebCrypto in secure contexts and collaboration encrypts with it. Terminate TLS at the ingress (`ingress.tls=true`) or at an external LB, and keep `ingress.scheme=https` in both cases.

## Limitations (important)

- The room server keeps rooms in memory (no shared adapter), so it is limited to one replica and a restart drops live sessions (clients keep local state and reconnect).
- Not available air-gapped: "export to shareable link" (`json.excalidraw.com` backend), public libraries (`libraries.excalidraw.com`), Excalidraw+, AI features, and image sync between collaborators (Firebase). Drawings, text and shapes sync fine.
- The NetworkPolicy (`networkPolicy.enabled`, off by default) allows only DNS egress; browsers still need to reach the ingress.
