<div align="center">

<img src="https://raw.githubusercontent.com/Devopstrio/.github/main/assets/Browser_logo.png" height="90" alt="Devopstrio Logo" />

<h1>Azure Virtual Desktop (AVD) Application Delivery Platform</h1>

<p><strong>Cloud-Native Desktop Virtualization & App-First Digital Workspace</strong></p>

[![Virtualization](https://img.shields.io/badge/Platform-Azure_Virtual_Desktop-0078d4?style=for-the-badge&logo=microsoftazure&labelColor=000000)](https://devopstrio.co.uk/)
[![Packaging](https://img.shields.io/badge/Tech-MSIX_App_Attach-522c72?style=for-the-badge&labelColor=000000)](/app-packages)
[![Security](https://img.shields.io/badge/Security-Zero_Trust_AVD-962964?style=for-the-badge&labelColor=000000)](/security)
[![Automated](https://img.shields.io/badge/Ops-Autoscale_Engine-success?style=for-the-badge&labelColor=000000)](/apps/autoscale-engine)

</div>

---

## 🏛️ Executive Summary

The **Azure Virtual Desktop (AVD) Application Delivery Platform** is a flagship enterprise solution designed to modernize how organizations deliver Windows applications, remote desktops, and secure workspaces at a global scale. 

By leveraging **MSIX App Attach**, **Automated Image Factories**, and **AI-driven Autoscale Engines**, this platform transfroms the complexity of VDI into a streamlined, app-first service. Whether supporting high-end CAD engineering workstations, isolated contractor environments, or global call center multi-session desktops, the platform ensures maximum performance, security, and cost-efficiency.

### Strategic Business Outcomes
- **Global Workforce Enablement**: Instantly provision secure workspaces for employees and contractors anywhere in the world with sub-second app delivery.
- **Cost Optimization**: Reduce Azure compute costs by up to 60% through intelligent session-density autoscaling and scheduled shutdown workflows.
- **Zero-Trust Delivery**: Establish granular Conditional Access policies, ensuring that sensitive regulated workloads are only accessible from compliant devices.
- **Image Lifecycle Management**: Eliminate "image bloat" with a centralized image factory that automates patching, sysprepping, and distribution to global regions.

---

## 🏗️ Technical Architecture Details

### 1. High-Level Enterprise Architecture
```mermaid
flowchart TD
    User["End User / BYOD"] --> Gateway["Global AVD Gateway"]
    Gateway["Global AVD Gateway"] --> HostPools["Session Host Pools"]
    HostPools["Session Host Pools"] --> AppAttach["MSIX App Attach Cache"]
    HostPools["Session Host Pools"] --> Profiles["FSLogix Profiles"]
    
    subgraph ControlPlane["AVD Control Plane"]
        API["Platform API"]
        Autoscale["Autoscale Engine"]
        Workflow["Image Engine"]
    end
    
    API --> HostPools
    Autoscale --> HostPools
    Workflow --> Gallery["Azure Compute Gallery"]
    Gallery["Azure Compute Gallery"] --> HostPools
```

### 2. User Login & Workspace Lifecycle
```mermaid
sequenceDiagram
    participant User
    participant MFA as Entra ID/MFA
    participant Gateway as AVD Gateway
    participant Agent as Session Host Agent
    participant FSLogix as Profile Provider

    User->>MFA: Authenticate
    MFA->>User: Grant Token
    User->>Gateway: Connect to Workspace
    Gateway->>Agent: Broker Session
    Agent->>FSLogix: Mount User VHDX
    Agent->>User: Transmit Pixel Stream
```

### 3. Application Publishing Lifecycle
```mermaid
flowchart LR
    Dev["App Owner"] --> Package["Packaging Engine"]
    Package["Packaging Engine"] --> MSIX["MSIX Image"]
    MSIX["MSIX Image"] --> Store["Azure Storage / Files"]
    Store["Azure Storage / Files"] --> Publish["Publish to App Group"]
    Publish["Publish to App Group"] --> User["User Workspace Access"]
```

### 4. Golden Image Pipeline (Packer + Bicep)
```mermaid
flowchart TD
    Trigger["Monthly Patch Cycle"] --> Build["Packer Build VM"]
    Build["Packer Build VM"] --> Patch["Windows Updates / Apps"]
    Patch["Windows Updates / Apps"] --> Sysprep["Capture & Sysprep"]
    Sysprep["Capture & Sysprep"] --> Gallery["Compute Gallery Version"]
    Gallery["Compute Gallery Version"] --> Reimage["Host Pool Rolling Upgrade"]
```

### 5. Autoscale Decision Logic
```mermaid
flowchart TD
    Monitor["Session Count / CPU"] --> Threshold["Check Scaling Rules"]
    Threshold["Check Scaling Rules"] -->|High Load| Provision["Spark New Session Hosts"]
    Threshold["Check Scaling Rules"] -->|Idle Sessions| Drain["Drain & Stop Hosts"]
    Provision["Spark New Session Hosts"] --> Register["AVD Registration"]
    Drain["Drain & Stop Hosts"] --> CostSave["Compute Cost Reduction"]
```

### 6. Security Trust Boundary
```mermaid
flowchart TD
    Public["Public Internet"] --> NSG["Azure Firewall / NSG"]
    NSG["Azure Firewall / NSG"] --> Private["Private Link AVD"]
    Private["Private Link AVD"] --> Host["Session Host"]
    Host["Session Host"] --> KeyVault["Key Vault Secrets"]
    Host["Session Host"] --> Defender["MS Defender for Endpoint"]
```

### 7. Global Hub-Spoke Topology
```mermaid
flowchart LR
    Hub["Hub VNet"] --> FW["Firewall"]
    Hub["Hub VNet"] --> Spoke1["Prod Spoke - UKS"]
    Hub["Hub VNet"] --> Spoke2["Dev Spoke - UKW"]
    Spoke1["Prod Spoke - UKS"] --> AVD1["Host Pool A"]
    Spoke2["Dev Spoke - UKW"] --> AVD2["Host Pool B"]
```

### 8. API Request Lifecycle
```mermaid
flowchart LR
    Admin["Admin UI"] --> API["FastAPI Gateway"]
    API["FastAPI Gateway"] --> Auth["RBAC Check"]
    API["FastAPI Gateway"] --> ARM["Azure Resource Manager"]
    ARM["Azure Resource Manager"] --> AVD["AVD Service"]
```

### 9. MSIX App Attach Mounting Workflow
```mermaid
flowchart TD
    Login["User Login"] --> Query["Query Assigned Apps"]
    Query["Query Assigned Apps"] --> Path["Find VHDX on Azure Files"]
    Path["Find VHDX on Azure Files"] --> Mount["Mount Junction Point"]
    Mount["Mount Junction Point"] --> App["App Appears to User"]
```

### 10. Multi-Tenant Resource Isolation
```mermaid
flowchart TD
    TenantA["Tenant A"] --> RG_A["Resource Group A"]
    TenantB["Tenant B"] --> RG_B["Resource Group B"]
    RG_A["Resource Group A"] --> PoolA["Pool A"]
    RG_B["Resource Group B"] --> PoolB["Pool B"]
    PoolA["Pool A"] -.-> SubA["Shared Subnet A"]
    PoolB["Pool B"] -.-> SubB["Shared Subnet B"]
```

### 11. Monitoring & Telemetry Flow
```mermaid
flowchart LR
    Agent["Log Analytics Agent"] --> LAW["Log Analytics Workspace"]
    LAW["Log Analytics Workspace"] --> Grafana["Grafana Dashboards"]
    LAW["Log Analytics Workspace"] --> Insights["AVD Insights"]
    Insights["AVD Insights"] --> Alerts["IT Admin Alerts"]
```

### 12. Disaster Recovery Topology
```mermaid
flowchart TD
    Region1["Primary: UK South"] --> Sync["Global Image Sync"]
    Sync["Global Image Sync"] --> Region2["Secondary: US East"]
    Region1["Primary: UK South"] --> Failover["DNS Failover"]
    Failover["DNS Failover"] --> Region2["Secondary: US East"]
```

### 13. Contractor Isolated Access Flow
```mermaid
flowchart TD
    Contractor["External User"] --> Conditional["Entra Conditional Access"]
    Conditional["Entra Conditional Access"] --> CAP["Secure Gateway"]
    CAP["Secure Gateway"] --> DedicatedPool["Sandboxed Host Pool"]
    DedicatedPool["Sandboxed Host Pool"] --> NoInternet["No Public Internet NSG"]
```

### 14. GPU Workstation Rendering Model
```mermaid
flowchart LR
    CAD["AutoCAD/Revit"] --> GPU["NVIDIA GRID VM"]
    GPU["NVIDIA GRID VM"] --> Encoders["NVENC Encoders"]
    Encoders["NVENC Encoders"] --> RDP["Remote Desktop Traffic"]
    RDP["Remote Desktop Traffic"] --> User["High Fidelity Display"]
```

### 15. Cost Optimization Workflow
```mermaid
flowchart TD
    History["Usage History"] --> AI["Forecast Engine"]
    AI["Forecast Engine"] --> Plan["Optimization Plan"]
    Plan["Optimization Plan"] --> AutoScale["Execute Scaling"]
    AutoScale["Execute Scaling"] --> Billing["Lower Azure Bill"]
```

### 16. Image Versioning & Rollback
```mermaid
flowchart LR
    V1["Image v1.0.0"] --> V2["Image v1.1.0"]
    V2["Image v1.1.0"] --> Error["Found Bug"]
    Error["Found Bug"] --> Rollback["Revert to v1.0.0"]
```

### 17. Host Pool Scaling Model
```mermaid
flowchart TD
    Breadth["Breadth First"] --> NewHost["Even Distribution"]
    Depth["Depth First"] --> Pack["Pack Session on One Host"]
    Pack["Pack Session on One Host"] --> Shutdown["Power off Others"]
```

### 18. CI/CD Operations Pipeline
```mermaid
flowchart LR
    Code["Infrastructure Code"] --> Plan["TF Plan"]
    Plan["TF Plan"] --> Test["Checkov/Static Scan"]
    Test["Checkov/Static Scan"] --> Apply["Deploy AVD Host Pool"]
```

### 19. Identity Federation Architecture
```mermaid
flowchart TD
    ADDS["On-Prem AD"] --> Connect["Entra Connect"]
    Connect["Entra Connect"] --> Cloud["Entra ID"]
    Cloud["Entra ID"] --> AVD["AVD Authenticated Sso"]
```

### 20. Executive Governance Workflow
```mermaid
flowchart TD
    Compliance["New Regulation"] --> Policy["Policy-as-Code"]
    Policy["Policy-as-Code"] --> Deployment["Automatic Hardening"]
    Deployment["Automatic Hardening"] --> Report["Executive Compliance Review"]
```

---

## 🛠️ Global Platform Components

| Engine | Directory | Purpose |
|:---|:---|:---|
| **AVD Portal** | `apps/portal/` | Executive Next.js interface for managing remote sessions and host pools. |
| **Workspace Engine**| `apps/workspace-engine/` | Logic for provisioning host pools, workspaces, and application groups. |
| **Autoscale Engine** | `apps/autoscale-engine/` | Python-driven agent that manages VM power states based on user density. |
| **Image Engine** | `apps/image-engine/` | Automation of Azure Compute Gallery and golden image versions. |

---

## 🚀 Environment Deployment

Deploy the infrastructure.

```bash
cd terraform/environments/prod
terraform init
terraform apply -auto-approve
```

---
<sub>&copy; 2026 Devopstrio &mdash; Redefining the Digital Workplace.</sub>
