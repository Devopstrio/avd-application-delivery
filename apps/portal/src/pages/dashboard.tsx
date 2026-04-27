import React from 'react';

// Devopstrio AVD Application Delivery
// Executive Virtual Desktop Dashboard

const Dashboard = () => {
    return (
        <div className="min-h-screen bg-slate-950 text-slate-200 font-sans">
            {/* Sidebar Navigation */}
            <div className="flex h-screen overflow-hidden">
                <aside className="w-64 bg-slate-900 border-r border-slate-800 flex flex-col p-6 space-y-8">
                    <div className="flex items-center gap-3">
                        <div className="w-8 h-8 rounded bg-indigo-600 flex items-center justify-center font-bold text-white shadow-[0_0_15px_rgba(79,70,229,0.5)]">
                            DV
                        </div>
                        <h1 className="text-lg font-bold tracking-tight text-white">AVD Ops</h1>
                    </div>

                    <nav className="flex-1 space-y-1">
                        {[
                            { name: 'Dashboard', icon: 'M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6', active: true },
                            { name: 'Host Pools', icon: 'M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10', active: false },
                            { name: 'Application Catalog', icon: 'M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-14v14m0-14L4 7m8 4v10M4 7v10l8 4', active: false },
                            { name: 'Image Lifecycle', icon: 'M19 11a7 7 0 01-7 7m0 0a7 7 0 01-7-7m7 7v4m0 0H8m4 0h4m-4-8a3 3 0 01-3-3V5a3 3 0 116 0v6a3 3 0 01-3 3z', active: false },
                            { name: 'User Analytics', icon: 'M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z', active: false },
                        ].map((item) => (
                            <a
                                key={item.name}
                                href="#"
                                className={`flex items-center gap-3 px-3 py-2 rounded-lg text-sm font-medium transition-all ${item.active ? 'bg-indigo-600/10 text-indigo-400 border border-indigo-600/20 shadow-sm' : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200'
                                    }`}
                            >
                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d={item.icon} />
                                </svg>
                                {item.name}
                            </a>
                        ))}
                    </nav>

                    <div className="bg-slate-800/50 rounded-xl p-4 border border-slate-700">
                        <div className="flex items-center justify-between mb-2">
                            <span className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">Platform Status</span>
                            <span className="w-2 h-2 rounded-full bg-emerald-500 shadow-[0_0_10px_rgba(16,185,129,0.5)]"></span>
                        </div>
                        <p className="text-xs text-slate-400 leading-tight">Global AVD Brokers are operational across all regions.</p>
                    </div>
                </aside>

                {/* Main Content */}
                <main className="flex-1 overflow-y-auto bg-slate-950 p-8">
                    <header className="flex justify-between items-center mb-10">
                        <div>
                            <h2 className="text-3xl font-black text-white tracking-tight">EUC Command Center</h2>
                            <p className="text-slate-400 mt-1">Real-time oversight of global virtual desktops and application sessions.</p>
                        </div>
                        <div className="flex gap-4">
                            <button className="bg-slate-800 hover:bg-slate-700 text-white px-4 py-2 rounded-lg border border-slate-700 transition-all text-sm font-semibold">
                                Generate Report
                            </button>
                            <button className="bg-indigo-600 hover:bg-indigo-500 text-white px-4 py-2 rounded-lg shadow-lg shadow-indigo-600/20 transition-all text-sm font-semibold">
                                New Host Pool
                            </button>
                        </div>
                    </header>

                    {/* KPI Grid */}
                    <section className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-10">
                        {[
                            { label: 'Active Sessions', value: '1,420', sub: '+12% from peak yesterday', color: 'indigo' },
                            { label: 'Host Utilization', value: '78.4%', sub: 'Healthy session density', color: 'emerald' },
                            { label: 'Login Latency', value: '42s', sub: 'Average across EU regions', color: 'amber' },
                            { label: 'Scaling Savings', value: '$12,402', sub: 'Automated shutdown impact', color: 'purple' },
                        ].map((kpi) => (
                            <div key={kpi.label} className="bg-slate-900 p-6 rounded-2xl border border-slate-800 hover:border-slate-700 transition-all shadow-sm">
                                <span className="text-[10px] font-bold text-slate-500 uppercase tracking-widest">{kpi.label}</span>
                                <div className="text-3xl font-black text-white mt-2 font-mono">{kpi.value}</div>
                                <div className={`text-xs font-semibold mt-2 text-${kpi.color}-400`}>{kpi.sub}</div>
                            </div>
                        ))}
                    </section>

                    {/* Regional Health Map / Table */}
                    <section className="grid grid-cols-1 xl:grid-cols-3 gap-8 mb-10">
                        <div className="xl:col-span-2 bg-slate-900 rounded-2xl border border-slate-800 p-8 shadow-sm">
                            <div className="flex justify-between items-center mb-8">
                                <h3 className="text-lg font-bold text-white">Active Host Pools</h3>
                                <div className="flex bg-slate-800 p-1 rounded-lg border border-slate-700">
                                    <button className="px-3 py-1 bg-indigo-600 text-[10px] font-bold text-white rounded-md uppercase tracking-wider">Pooled</button>
                                    <button className="px-3 py-1 text-[10px] font-bold text-slate-400 rounded-md uppercase tracking-wider">Dedicated</button>
                                </div>
                            </div>

                            <div className="space-y-4">
                                {[
                                    { name: 'avd-pool-engineering-uk', hosts: 24, sessions: 182, status: 'Healthy', load: '75%' },
                                    { name: 'avd-pool-corporate-de', hosts: 80, sessions: 642, status: 'Healthy', load: '80%' },
                                    { name: 'avd-pool-gpu-rendering', hosts: 8, sessions: 14, status: 'Healthy', load: '40%' },
                                    { name: 'avd-pool-contractor-ext', hosts: 12, sessions: 45, status: 'Draining', load: '10%' },
                                ].map((pool) => (
                                    <div key={pool.name} className="flex items-center justify-between p-4 bg-slate-800/40 rounded-xl border border-slate-800 hover:border-slate-700 transition-all">
                                        <div className="flex items-center gap-4">
                                            <div className="w-10 h-10 rounded-lg bg-slate-800 border border-slate-700 flex items-center justify-center">
                                                <svg className="w-5 h-5 text-indigo-400" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 11H5m14 0a2 2 0 012 2v6a2 2 0 01-2 2H5a2 2 0 01-2-2v-6a2 2 0 012-2m14 0V9a2 2 0 00-2-2M5 11V9a2 2 0 012-2m0 0V5a2 2 0 012-2h6a2 2 0 012 2v2M7 7h10" /></svg>
                                            </div>
                                            <div>
                                                <div className="font-bold text-slate-200">{pool.name}</div>
                                                <div className="text-xs text-slate-500 font-medium">{pool.hosts} Hosts • {pool.sessions} Sessions • {pool.load} Load Index</div>
                                            </div>
                                        </div>
                                        <div className="flex items-center gap-6">
                                            <span className={`text-[10px] font-bold uppercase tracking-widest px-2 py-1 rounded border ${pool.status === 'Healthy' ? 'text-emerald-400 bg-emerald-400/10 border-emerald-400/20' : 'text-amber-400 bg-amber-400/10 border-amber-400/20'}`}>
                                                {pool.status}
                                            </span>
                                            <button className="text-slate-400 hover:text-white">
                                                <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" /></svg>
                                            </button>
                                        </div>
                                    </div>
                                ))}
                            </div>
                        </div>

                        <div className="bg-slate-900 rounded-2xl border border-slate-800 p-8 shadow-sm h-fit">
                            <h3 className="text-lg font-bold text-white mb-6">App Delivery Status</h3>
                            <div className="space-y-6">
                                {[
                                    { app: 'AutoCAD Mechanical', type: 'App Attach', status: 'Active', latency: '4ms' },
                                    { app: 'Visual Studio 2022', type: 'MSIX', status: 'Active', latency: '12ms' },
                                    { app: 'SAP GUI', type: 'Win32', status: 'Active', latency: '8ms' },
                                    { app: 'Adobe Premiere', type: 'App Attach', status: 'Processing', latency: '--' },
                                ].map((app) => (
                                    <div key={app.app} className="flex justify-between items-center group">
                                        <div>
                                            <div className="text-sm font-bold text-slate-200 group-hover:text-indigo-400 transition-colors">{app.app}</div>
                                            <div className="text-[10px] text-slate-500 uppercase font-bold tracking-tighter">{app.type}</div>
                                        </div>
                                        <div className="text-right">
                                            <div className="text-xs font-bold text-slate-300">{app.latency}</div>
                                            <div className="text-[10px] text-emerald-400 font-bold">{app.status}</div>
                                        </div>
                                    </div>
                                ))}
                            </div>
                            <button className="w-full mt-8 bg-slate-800 text-slate-200 text-xs font-bold py-3 rounded-xl border border-slate-700 hover:bg-slate-700 transition-all">
                                Full Application Catalog
                            </button>
                        </div>
                    </section>
                </main>
            </div>
        </div>
    );
};

export default Dashboard;
