# Articola Tools' Dockerfile security scanner

[![image size](https://ghcr-badge.egpl.dev/articola-tools/dockerfile-security-scanner/size?color=dodgerblue)](https://ghcr-badge.egpl.dev/articola-tools/dockerfile-security-scanner/size?color=dodgerblue)

This repo contains Dockerfile with preconfigured [Dockerfile security scanner](https://github.com/aquasecurity/trivy).
This scanner is used in Articola Tools organization's repositories to scan
Dockerfiles for vulnerabilities.

## Usage

Use `ghcr.io/articola-tools/dockerfile-security-scanner` Docker image with the
following parameters:

- `--group-add $(getent group docker | cut -d: -f3)` - to allow access to
  `/var/run/docker.sock`
- `-v /var/run/docker.sock:/var/run/docker.sock` - to mount Docker socket to
  container
- name of an image to scan

Example command to use this scanner:

```bash
docker run --rm --group-add $(getent group docker | cut -d: -f3) \
-v /var/run/docker.sock:/var/run/docker.sock \
ghcr.io/articola-tools/dockerfile-security-scanner your-image-to-scan:latest
```
