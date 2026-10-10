# Trilium Notes for TerraMaster TOS 7

TOS 7 App Center package for [Trilium Notes](https://github.com/TriliumNext/Trilium) — a hierarchical note-taking application for building a personal knowledge base.

一个把 [Trilium Notes](https://github.com/TriliumNext/Trilium) 打包上架到 TOS 7 应用中心的 Docker 应用（单容器、单数据卷、零外部依赖）。

---

## What it does / 这是什么

Trilium arranges notes as a tree and runs entirely inside a Docker container on your TNAS.

- Hierarchical notes: rich text, code blocks, images, diagrams, relations and canvases
- Attributes, saved searches, note revisions and per-note encryption
- Built-in full-text search across the whole tree
- Web UI on host port `10004` → container port `8080`
- No external database, no root, no privileged mode

## Package contents / 包内文件

```
trilium.tar.gz
├── config.ini            # TOS application metadata
├── trilium.lang          # 14 languages (zh-cn, zh-hk, en-us, ... pt-pt)
├── trilium.svg           # application icon (SVG, transparent background)
└── docker-compose.yml    # container definition
```

## docker-compose.yml

```yaml
version: "3.8"

services:
  trilium:
    image: triliumnext/trilium:v0.106.0
    restart: unless-stopped
    user: "1000:1000"
    ports:
      - "10004:8080"
    volumes:
      - ./data:/home/node/trilium-data
    environment:
      - TZ=Asia/Shanghai
```

`x-app-meta` declares `web.port: 10004` / `web.protocol: http`, as required for Docker applications with a Web UI.

## Design decisions

**Non-root execution.** The upstream entrypoint is written for both cases: started as `1000:1000`
it skips the `node` user remapping and runs the server directly as the non-root user.

**Credentials.** Trilium has no default account and no environment variable for a password. The
first page of the web UI asks the user to finish the initial setup, including the access password,
so no credential has to be created or stored by this package.

**Container name.** `container_name` is intentionally omitted, so Compose derives a globally
unique name (`<project>_<service>_1`). The platform only appends a numeric suffix to a conflicting
*project* name — it does not rewrite `container_name` — so hard-coding a container name would make
installation fail on a device that already runs a container called `trilium`.

## Data location / 数据位置

The host side of `./data` is resolved by the platform to the application data root:

```
/Volume<N>/DockerAppData/trilium/data
```

The database (`document.db`), configuration and logs all live there. Data survives uninstall and
reinstall as long as "delete data" is not selected.

## Build

```bash
./build.sh            # produces trilium.tar.gz + trilium.tar.gz.sha256
```

The archive must contain the four files at its root:

```bash
tar -czf trilium.tar.gz config.ini trilium.lang trilium.svg docker-compose.yml
sha256sum trilium.tar.gz > trilium.tar.gz.sha256
```

## Release

The package is published as a Release asset (the TOS Developer Platform downloads the package from
the Release, not from the repository root):

- Tag: `1.0.0`
- Asset: `trilium.tar.gz`
- Checksum: `trilium.tar.gz.sha256`

## Compliance notes / 合规说明

- Image source: Docker Hub only (`triliumnext/trilium`), version tag pinned, never `:latest`.
- Runs as a non-root user (`user: "1000:1000"`); no `privileged`, no `network_mode: host`.
- No hardcoded credentials, tokens or secrets in the image or the compose file.
- No secrets are written to container logs.
- The icon in this repository is original artwork created for this package; it is **not** the
  upstream project logo, to avoid trademark issues.
- This repository contains packaging metadata only. The application itself is developed by the
  Trilium Next project and distributed under its own license (AGPL-3.0). All credit belongs to the
  upstream authors.
- Ports 22, 80, 443, 445, 3306, 5050, 5432, 6379, 8181 and 8443 are not used.

## Links

- Upstream project: https://github.com/TriliumNext/Trilium
- Docker Hub image: https://hub.docker.com/r/triliumnext/trilium
- TOS 7 development guide: https://github.com/terramaster-tos/tos-app-pkg-tools
