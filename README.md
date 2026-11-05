# Node.js

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-node) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnode) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnode) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-node/build.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/node) - [Quay.io](https://quay.io/repository/bfren/node) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

[Node.js](https://nodejs.org) and `npm`, running your app as a supervised service. It is built on [Alpine + S6](https://github.com/bfren/docker-alpine-s6), with Node.js from Alpine's packages - each Node.js version uses the newest Alpine release that has it.

The image runs `/app/live/index.js` as the `node` user. Use it as the base for a Node.js app's image (as [Send](https://github.com/bfren/docker-send) does), or mount a ready-to-run app into it.

## Quickstart

With your app (including `node_modules`) in `./app`, and `index.js` listening on port 3000:

```yaml
services:
  app:
    image: quay.io/bfren/node:node24-6.0
    restart: unless-stopped
    ports:
      - "127.0.0.1:3000:3000"
    volumes:
      - ./app:/app/live
```

Run `docker compose up -d`, then open `http://127.0.0.1:3000`. Without your own app, a welcome page is shown.

Your app must listen on `0.0.0.0` (all interfaces), not `127.0.0.1` - otherwise it can't be reached through the published port.

## Features

* 🟩 Node.js 20 to 26 - choose with the image tag
* 📦 `npm` installed
* 🧭 Your app runs under S6 supervision as `node` (UID 1000), not root
* 🛑 The container stops if your app crashes, so Docker can restart it
* 🔐 `/app/live` is made read-only for the app on every start
* 🧪 Built-in tests

## Tags

Images are published to Docker Hub (`bfren/node`) and Quay.io (`quay.io/bfren/node`) for `linux/amd64`, `linux/arm/v7` and `linux/arm64`.

| Tag               | Example           | Use when                                        |
| ----------------- | ----------------- | ----------------------------------------------- |
| `nodeN`           | `node24`          | You want the latest image for a Node.js version |
| `nodeN-MAJOR`     | `node24-6`        | You want updates, but not breaking changes      |
| `nodeN-MINOR`     | `node24-6.0`      | You want fixes only - **recommended**           |
| `nodeN-VERSION`   | `node24-6.0.0`    | You want to pin this image exactly              |
| `nodeN.M`         | `node24.22`       | You want an exact Node.js release               |
| `nodeN.M-VERSION` | `node24.22-6.0.0` | You want to pin both                            |

There is no `latest` tag - always choose a Node.js version.

| Node.js | Release | Alpine | Security support ends |
| ------- | ------- | ------ | --------------------- |
| 26      | 26.12.1 | 3.24   | 2029-04-30 (LTS)      |
| 24      | 24.22.1 | 3.24   | 2028-04-30 (LTS)      |
| 23      | 23.11.1 | 3.22   | ended 2025-06-01      |
| 22      | 22.23.4 | 3.22   | 2027-04-30 (LTS)      |
| 21      | 21.7.3  | 3.20   | ended 2024-06-01      |
| 20      | 20.15.1 | 3.20   | ended 2026-04-30      |

Use an LTS version for anything long-lived - see the [Node.js release schedule](https://nodejs.org/en/about/previous-releases). Images for versions that have ended are still built, but get no Node.js fixes.

## Configuration

### Ports

| Port   | Purpose                                               |
| ------ | ----------------------------------------------------- |
| `3000` | Used by the welcome page - your app can use any port. |

### Volumes

| Volume      | Purpose                                |
| ----------- | -------------------------------------- |
| `/app/live` | Your app - `index.js` is run on start. |

### Environment Variables

This image adds none of its own. See [Alpine + S6](https://github.com/bfren/docker-alpine-s6#environment-variables) for `BF_DEBUG`, `BF_TZ` and the other base image variables. Your app can read any variables you pass to the container.

## How It Works

On every start the Node.js and `npm` versions are written to the log, and everything in `/app/live` is given to the `node` user and made read-only (`0400` files, `0500` folders). Then `node /app/live/index.js` runs under S6 as `node`.

If your app crashes (exits with an error), the container stops - set a `restart` policy so Docker starts it again. If it exits cleanly, S6 starts it again inside the container.

The health check is the base image's, which checks cron is running - it doesn't check your app. To check your app, add a script to `/etc/bf/health.d` in your own image (see [Alpine + S6](https://github.com/bfren/docker-alpine-s6#health-checks)).

## Building on this image

Copy your app into `/app/live` and install its dependencies when the image is built:

```dockerfile
FROM quay.io/bfren/node:node24-6.0

COPY ./app /app/live
RUN cd /app/live && npm ci --omit=dev
```

`index.js` must be the entry point. If your app's entry point is elsewhere, add an `index.js` that loads it, e.g. `require('./dist/server.js');`.

## Testing

```sh
./test.nu                   # builds Node.js 24 and runs /test
./test.nu 20                # or any version directory
./test.nu --all             # every version, in parallel
./run.sh 24                 # builds and opens a shell
./generate-dockerfiles.sh   # regenerates the Dockerfiles from Dockerfile.esh
```

`/test` runs this image's tests alongside the base images' tests: the app paths, the welcome page (valid JavaScript, listening on all interfaces), the installed Node.js and `npm` versions, and the service scripts.

## Troubleshooting

### The container stops straight after starting

Your app crashed. Check `docker logs <container>` for its error - often a missing `node_modules` folder, or no `/app/live/index.js`.

### My app can't write files (`EACCES`)

`/app/live` is read-only on purpose. Write data to another folder, and mount a volume there.

### The port is published but nothing answers

Your app is probably listening on `127.0.0.1` or `localhost` - change it to `0.0.0.0`.

## FAQs

### How do I run `npm install` in the container?

`docker exec <container> sh -c 'cd /app/live && npm install'` works, but installing when the image is built (see [Building on this image](#building-on-this-image)) is more reliable, and the new files are only given to `node` on the next start.

### Can I use a different entry file?

Not directly - `/app/live/index.js` is always run. Make it load your real entry point.

## Licence

> [MIT](https://mit.bfren.dev/2022)

## Copyright

> Copyright (c) 2022-2026 [bfren](https://bfren.dev) (unless otherwise stated)
