# Privacy Policy - Trilium Notes for TerraMaster TOS 7

**Application**: Trilium Notes (`app_id: trilium`)
**Publisher**: waskevin
**Policy version**: 1.0
**Effective date**: 2026-11-09
**Contact**: https://github.com/waskevin/trilium/issues

This policy covers the TOS 7 application package distributed by waskevin
(the `trilium.tar.gz` archive and the `config.ini` / `trilium.lang` / `trilium.svg` /
`docker-compose.yml` files inside it) and the container it starts on your
device.  It does not cover the Trilium Notes project's own website or any service you
connect the application to.

## What the package itself does

- It runs one Docker container from the public image `triliumnext/trilium:v0.106.0`.
- It does not contain analytics, telemetry, advertising or tracking code.
- It does not send any data to waskevin or to any third party.
- It does not open network connections on its own; the only traffic is what
  the application and your browser make.

## Data the application stores

All application data (one SQLite database plus note attachments, in
`data/`) is written to
`/Volume<N>/DockerAppData/trilium/`.  Nothing is
uploaded anywhere by the packaging.

## Data the application may send

- The application contacts no third party on its own. It has no telemetry,
  no update ping and no crash reporting.
- The only traffic is the HTTP requests your browser makes to port 10004.

## Removing your data

Uninstalling the application from the TOS App Center stops and removes the
container.  Deleting the folder `DockerAppData/trilium/` on your device removes
all remaining data; nothing is left elsewhere.

## Changes

Any change to this policy is published in this repository together with the
version of the package it applies to.
