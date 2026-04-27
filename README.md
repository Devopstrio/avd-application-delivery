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
graph TD
    User[End User / BYOD] --> Gateway[Global AVD Gateway]
    Gateway --> HostPools[Session Host Pools]
    HostPools --> AppAttach[MSIX App Attach Cache]
    HostPools --> Profiles[FSLogix Profiles]
    
    subgraph ControlPlane[AVD Control Plane]
        API[Platform API]
        Autoscale[Autoscale Engine]
        Workflow[Image Engine]
    end
    
    API --> HostPools
    Autoscale --> HostPools
    Workflow --> Gallery[Azure Compute Gallery]
    Gallery --> HostPools
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
graph LR
    Dev[App Owner] --> Package[Packaging Engine]
    Package --> MSIX[MSIX Image]
    MSIX --> Store[Azure Storage / Files]
    Store --> Publish[Publish to App Group]
    Publish --> User[User Workspace Access]
```

### 4. Golden Image Pipeline (Packer + Bicep)
```mermaid
graph TD
    Trigger[Monthly Patch Cycle] --> Build[Packer Build VM]
    Build --> Patch[Windows Updates / Apps]
    Patch --> Sysprep[Capture & Sysprep]
    Sysprep --> Gallery[Compute Gallery Version]
    Gallery --> Reimage[Host Pool Rolling Upgrade]
```

### 5. Autoscale Decision Logic
```mermaid
graph TD
    Monitor[Session Count / CPU] --> Threshold[Check Scaling Rules]
    Threshold -->|High Load| Provision[Spark New Session Hosts]
    Threshold -->|Idle Sessions| Drain[Drain & Stop Hosts]
    Provision --> Register[AVD Registration]
    Drain --> CostSave[Compute Cost Reduction]
```

### 6. Security Trust Boundary
```mermaid
graph TD
    Public[Public Internet] --> NSG[Azure Firewall / NSG]
    NSG --> Private[Private Link AVD]
    Private --> Host[Session Host]
    Host --> KeyVault[Key Vault Secrets]
    Host --> Defender[MS Defender for Endpoint]
```

### 7. Global Hub-Spoke Topology
```mermaid
graph LR
    Hub[Hub VNet] --> FW[Firewall]
    Hub --> Spoke1[Prod Spoke - UKS]
    Hub --> Spoke2[Dev Spoke - UKW]
    Spoke1 --> AVD1[Host Pool A]
    Spoke2 --> AVD2[Host Pool B]
```

### 8. API Request Lifecycle
```mermaid
graph LR
    Admin[Admin UI] --> API[FastAPI Gateway]
    API --> Auth[RBAC Check]
    API --> ARM[Azure Resource Manager]
    ARM --> AVD[AVD Service]
```

### 9. MSIX App Attach Mounting Workflow
```mermaid
graph TD
    Login[User Login] --> Query[Query Assigned Apps]
    Query --> Path[Find VHDX on Azure Files]
    Path --> Mount[Mount Junction Point]
    Mount --> App[App Appears to User]
```

### 10. Multi-Tenant Resource Isolation
```mermaid
graph TD
    TenantA[Tenant A] --> RG_A[Resource Group A]
    TenantB[Tenant B] --> RG_B[Resource Group B]
    RG_A --> PoolA[Pool A]
    RG_B --> PoolB[Pool B]
    PoolA -.-> SubA[Shared Subnet A]
    PoolB -.-> SubB[Shared Subnet B]
```

### 11. Monitoring & Telemetry Flow
```mermaid
graph LR
    Agent[Log Analytics Agent] --> LAW[Log Analytics Workspace]
    LAW --> Grafana[Grafana Dashboards]
    LAW --> Insights[AVD Insights]
    Insights --> Alerts[IT Admin Alerts]
```

### 12. Disaster Recovery Topology
```mermaid
graph TD
    Region1[Primary: UK South] --> Sync[Global Image Sync]
    Sync --> Region2[Secondary: US East]
    Region1 --> Failover[DNS Failover]
    Failover --> Region2
```

### 13. Contractor Isolated Access Flow
```mermaid
graph TD
    Contractor[External User] --> Conditional[Entra Conditional Access]
    Conditional --> CAP[Secure Gateway]
    CAP --> DedicatedPool[Sandboxed Host Pool]
    DedicatedPool --> NoInternet[No Public Internet NSG]
```

### 14. GPU Workstation Rendering Model
```mermaid
graph LR
    CAD[AutoCAD/Revit] --> GPU[NVIDIA GRID VM]
    GPU --> Encoders[NVENC Encoders]
    Encoders --> RDP[Remote Desktop Traffic]
    RDP --> User[High Fidelity Display]
```

### 15. Cost Optimization Workflow
```mermaid
graph TD
    History[Usage History] --> AI[Forecast Engine]
    AI --> Plan[Optimization Plan]
    Plan --> AutoScale[Execute Scaling]
    AutoScale --> Billing[Lower Azure Bill]
```

### 16. Image Versioning & Rollback
```mermaid
graph LR
    V1[Image v1.0.0] --> V2[Image v1.1.0]
    V2 --> Error[Found Bug]
    Error --> Rollback[Revert to v1.0.0]
```

### 17. Host Pool Scaling Model
```mermaid
graph TD
    Breadth[Breadth First] --> NewHost[Even Distribution]
    Depth[Depth First] --> Pack[Pack session on one host]
    Pack --> Shutdown[Power off others]
```

### 18. CI/CD Operations Pipeline
```mermaid
graph LR
    Code[Infrastructure Code] --> Plan[TF Plan]
    Plan --> Test[Checkov/Static Scan]
    Test --> Apply[Deploy AVD Host Pool]
```

### 19. Identity Federation Architecture
```mermaid
graph TD
    ADDS[On-Prem AD] --> Connect[Entra Connect]
    Connect --> Cloud[Entra ID]
    Cloud --> AVD[AVD Authenticated Sso]
```

### 20. Executive Governance Workflow
```mermaid
graph TD
    Compliance[New Regulation] --> Policy[Policy-as-Code]
    Policy --> Deployment[Automatic Hardening]
    Deployment --> Report[Executive Compliance Review]
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
