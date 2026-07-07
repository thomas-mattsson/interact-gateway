az acr import --name <acr> `
    --source mcr.microsoft.com/cbl-mariner/busybox:2.0 `
    --image utils/busybox:2.0

az acr import --name <acr> `
  --source cp.icr.io/cp/datapower/datapower-nano-management:1.0.0 `
  --image  cp-mirror/cp/datapower/datapower-nano-management:1.0.0 `
  --username cp --password ibm-entitlement-key-pw

az acr import --name <acr> `
  --source cp.icr.io/cp/datapower/datapower-nano-runtime:1.0.0 `
  --image  cp-mirror/cp/datapower/datapower-nano-runtime:1.0.0 `
  --username cp --password ibm-entitlement-key-pw

az acr import --name <acr> `
  --source cp.icr.io/cp/datapower/datapower-nano-operator:1.0.0 `
  --image  cp-mirror/cp/datapower/datapower-nano-operator:1.0.0 `
  --username cp --password ibm-entitlement-key-pw