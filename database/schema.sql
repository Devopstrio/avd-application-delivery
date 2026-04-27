-- Devopstrio AVD Application Delivery
-- Database Schema for AVD Platform Management
-- Target: PostgreSQL 14+

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Organizational & User Management
CREATE TABLE IF NOT EXISTS tenants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name VARCHAR(255) UNIQUE NOT NULL,
    azure_tenant_id VARCHAR(100) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL -- Admin, WorkspaceManager, Helpdesk, User
);

CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    email VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    role_id INT REFERENCES roles(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 2. AVD Infrastructure Mapping
CREATE TABLE IF NOT EXISTS host_pools (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    resource_group VARCHAR(255) NOT NULL,
    pool_type VARCHAR(50) NOT NULL DEFAULT 'Pooled', -- Pooled, Personal
    load_balancer_type VARCHAR(50) DEFAULT 'BreadthFirst', -- BreadthFirst, DepthFirst
    max_session_limit INT DEFAULT 10,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS session_hosts (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_pool_id UUID REFERENCES host_pools(id) ON DELETE CASCADE,
    vm_name VARCHAR(255) NOT NULL,
    vm_resource_id TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Available', -- Available, Unavailable, Shutdown, Draining
    last_heartbeat TIMESTAMP WITH TIME ZONE,
    current_session_count INT DEFAULT 0
);

-- 3. Application Management
CREATE TABLE IF NOT EXISTS applications (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    package_type VARCHAR(50) NOT NULL, -- MSIX, AppAttach, Win32
    package_path TEXT NOT NULL,
    version VARCHAR(50) NOT NULL,
    is_published BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS app_groups (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_pool_id UUID REFERENCES host_pools(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    app_group_type VARCHAR(50) NOT NULL, -- RemoteApp, Desktop
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS app_group_assignments (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    app_group_id UUID REFERENCES app_groups(id) ON DELETE CASCADE,
    application_id UUID REFERENCES applications(id) ON DELETE CASCADE
);

-- 4. Image Lifecycle
CREATE TABLE IF NOT EXISTS images (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    version VARCHAR(50) NOT NULL,
    gallery_resource_id TEXT NOT NULL,
    status VARCHAR(50) DEFAULT 'Active', -- Active, Deprecated, Building
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 5. Automation & Scaling
CREATE TABLE IF NOT EXISTS scaling_jobs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_pool_id UUID REFERENCES host_pools(id),
    action VARCHAR(50) NOT NULL, -- ScaleUp, ScaleDown, Shutdown
    vm_count INT NOT NULL,
    status VARCHAR(50) DEFAULT 'Pending',
    started_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    completed_at TIMESTAMP WITH TIME ZONE
);

-- 6. Observability
CREATE TABLE IF NOT EXISTS usage_metrics (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    host_pool_id UUID REFERENCES host_pools(id),
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    active_sessions INT NOT NULL,
    cpu_utilization FLOAT,
    memory_utilization FLOAT
);

-- 7. Audit & Reporting
CREATE TABLE IF NOT EXISTS reports (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    tenant_id UUID REFERENCES tenants(id),
    report_type VARCHAR(100) NOT NULL,
    file_path TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS audit_logs (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id UUID REFERENCES users(id),
    action VARCHAR(255) NOT NULL,
    resource_type VARCHAR(100),
    resource_id VARCHAR(255),
    details JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for performance
CREATE INDEX idx_session_hosts_pool ON session_hosts(host_pool_id);
CREATE INDEX idx_usage_metrics_pool ON usage_metrics(host_pool_id, timestamp);
CREATE INDEX idx_app_assignments_group ON app_group_assignments(app_group_id);
