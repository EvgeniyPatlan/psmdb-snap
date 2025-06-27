# Percona Distribution for MongoDB 8.0 (Snap Package)

This project provides a secure, self-contained Snap package of **Percona Server for MongoDB 8.0** with integrated tools such as:

- `mongod` / `mongos`
- `percona-backup-mongodb` (PBM)
- `mongodb_exporter` for metrics
- `mongosh` shell
- Snap-friendly configuration and runtime management

> ✅ Built using [Snapcraft](https://snapcraft.io/docs/snapcraft-overview) and the official [Percona APT repository](https://docs.percona.com).

---

## 📦 Features

- Based on **Percona Server for MongoDB 8.0**
- Includes **PBM** for consistent backup
- Includes **mongodb_exporter** for Prometheus-compatible metrics
- Supports both `mongod` and `mongos`
- Snap confinement: `strict` and secure
- User-controlled configuration via `snap set`

---

## 🛠 How to Build

### Requirements

- Snapcraft (`sudo snap install snapcraft --classic`)
- LXD (`sudo snap install lxd && sudo lxd init`)
- GNU Make

### Build and Install

```bash
git clone https://github.com/YOUR_ORG/percona-distribution-mongodb-80.git
cd percona-distribution-mongodb-80

# Build the Snap
make build

# Install locally
make install
```

---

## 🚀 How to Use

### Start `mongod` daemon

```bash
sudo snap start percona-distribution-mongodb-80.mongod
```

### Connect using `mongosh`

```bash
percona-distribution-mongodb-80.mongosh
```

### Configure PBM Agent

```bash
sudo snap set percona-distribution-mongodb-80 pbm-uri="mongodb://localhost:27017"
sudo snap start percona-distribution-mongodb-80.pbm-agent
```

### Enable Prometheus Exporter

```bash
sudo snap set percona-distribution-mongodb-80 mongodb-uri="mongodb://localhost:27017"
sudo snap start percona-distribution-mongodb-80.mongodb-exporter
```

### Enable `mongos` (for sharded cluster)

```bash
sudo snap start percona-distribution-mongodb-80.mongos
```

---

## ⚙ Configuration Options

| Key            | Description                                        |
|----------------|----------------------------------------------------|
| `pbm-uri`      | MongoDB URI for PBM agent                          |
| `mongodb-uri`  | URI for exporter and other tools                   |
| `mongod-args`  | Extra args passed to `mongod`                      |
| `mongos-args`  | Extra args passed to `mongos`                      |

Example:

```bash
sudo snap set percona-distribution-mongodb-80 mongod-args="--bind_ip_all"
```

---

## 🧪 Development & Contribution

We welcome community contributions!

### Directory Layout

```text
snap/
├── snapcraft.yaml           # Snap definition
├── hooks/                   # Snap lifecycle hooks
└── local/                   # Wrapper scripts for daemons and commands
```

### Make Targets

```bash
make build        # Build the snap
make install      # Install locally
make logs         # View daemon logs
make remove       # Remove the installed snap
make set CONFIG=key VALUE=val
```

### Contribution Steps

1. Fork the repo and clone it
2. Make your changes in a branch
3. Test your build with Snapcraft and `make`
4. Submit a pull request 🎉

---
