# OpenVSCode Server with Java & Spring Boot

This repository contains a Docker setup for running [OpenVSCode Server](https://github.com/gitpod-io/openvscode-server) enhanced with Java development tools, specifically tailored for Spring Boot applications.

## Features

- **Base Image**: Built on `lscr.io/linuxserver/openvscode-server:latest`.
- **Java**: OpenJDK 17 (via [SDKMAN!](https://sdkman.io/)).
- **Maven**: Version 3.9 (via SDKMAN!).
- **Pre-installed VS Code Extensions**:
    - `vscjava.vscode-java-pack` (Java Extension Pack)
    - `vscjava.vscode-maven` (Maven for Java)
    - `vmware.vscode-boot-dev-pack` (Spring Boot Extension Pack)
    - `mblode.pretty-formatter` (Prettier Formatter)
    - `pkief.material-icon-theme` (Material Icon Theme)

## Getting Started

### Build the Image

To build the Docker image locally, run:

```bash
docker build -t openvscode-spring .
```

### Run the Container

To start the server and mount your current directory to `/code` inside the container:

```bash
docker run -it --init \
    -p 3000:3000 \
    -v "$(pwd):/code" \
    openvscode-spring
```

Access the IDE by navigating to `http://localhost:3000` in your web browser.

## Customization

### Build Arguments

You can customize the Java and Maven versions during the build process using build arguments:

```bash
docker build \
    --build-arg JAVA_VERSION=21.0.2-tem \
    --build-arg MAVEN_VERSION=3.9.6 \
    -t openvscode-spring-custom .
```

| Argument | Default | Description |
|----------|---------|-------------|
| `JAVA_VERSION` | `17.0.10-tem` | The version of Java to install via SDKMAN. |
| `MAVEN_VERSION` | `3.9.6` | The version of Maven to install via SDKMAN. |