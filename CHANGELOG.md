# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [6.0.0] - Unreleased

### Added

- Images for `linux/arm/v7` are built again.

### Changed

- **Breaking:** base image updated to `bfren/alpine-s6` 7.0.0 - see the
  [Alpine + S6 changelog](https://github.com/bfren/docker-alpine-s6/blob/main/CHANGELOG.md).
  `bf env set` must now run as root.
- Images are built and published by the shared `bfren/docker` build workflow (`build.yml`), replacing the separate
  `dev.yml` and `publish.yml` workflows.

### Removed

- **Breaking:** the `latest` and bare version (e.g. `6.0.0`) tags are no longer published - choose a Node.js version
  instead, e.g. `node24` or `node24-6`.

### Fixed

- The Node.js 24 image builds again - it now installs Alpine's `nodejs` package `24.22.1-r1`, which replaced
  `24.22.1-r0`.

[6.0.0]: https://github.com/bfren/docker-node/compare/v5.0.0...v6.0.0
