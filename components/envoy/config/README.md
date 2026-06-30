# Envoy Gateway Config

This directory contains a server-side apply patch for the `envoy-gateway-config` ConfigMap in `envoy-gateway-system`.

## Why a separate Argo Application?

The `envoy-gateway-config` ConfigMap is created and managed by the Envoy Gateway Helm chart (the `envoy-gateway` Argo Application). Placing our config changes in the same application as the operands would cause a field ownership conflict — the Helm app uses `prune: true` and would fight to reset `extensionApis` back to `{}`.

The dedicated `envoy-gateway-config` Argo Application (`argocd/operators/envoy-gateway-config.yaml`) solves this by:
- Using `ServerSideApply=true` with its own field manager
- Having no `prune: true` — it only owns the fields it declares
- Running independently of both the Helm operator app and the operands app

## What it configures

`envoy-gateway-config.yaml` patches the following fields onto the existing ConfigMap:

| Field | Value | Purpose |
|---|---|---|
| `extensionApis.enableBackend` | `true` | Enables the `Backend` CRD, required for routing to non-Kubernetes backends |
| `gateway.controllerName` | `gateway.envoyproxy.io/gatewayclass-controller` | Standard controller name |

All other fields in the ConfigMap (`logging`, `provider`, `rateLimitDeployment`, `shutdownManager`) are managed by the Helm chart and are not declared here — SSA leaves them untouched.

## Helm upgrade note

When upgrading the Envoy Gateway Helm chart (the `envoy-operator` Argo Application), the Helm release will re-assert its owned fields. This application will then re-apply `extensionApis.enableBackend: true` on the next sync. No manual intervention is needed, but verify the sync status after a Helm upgrade.
