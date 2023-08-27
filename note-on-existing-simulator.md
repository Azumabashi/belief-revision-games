# Note on the existing simulator
## Introduction
The existing belief revision games simulator [1] does not work in my computer by the command the authors presented. I have successeded to execute it by following way. This may be helpful for you.

## About OS and software versions

- Operating System: macOS Ventura 13.5
- OpenJDK: 20.0.1
- Docker Desktop: 4.19.0

## How to work the existing simulator
Note that the instruction from 1 to 4 is based on [2].

1. Install XQuatz
2. Launch XQuatz and open preference settings
3. In the security tab, check "Allow connections from network clients"
4. In the XQuatz window (like terminal), execute `xhost + ${hostname}`. After configuration, it should be kept launching.
5. Install Docker Desktop
6. Create `Dockerfile` and `compose.yaml` in the directory which `brg.jar` downloaded from [1] exists
7. Copy and paste following contents to `Dockerfile` and `compose.yaml`, respectively

`Dockerfile`:

```Dockerfile
FROM ibmjava:8

RUN apt update
RUN apt install -y libxtst6 libxi6 libxft2
WORKDIR /workspace
```

`compose.yaml`:

```yaml
version: '3'
services:
  container:
    build: .
    tty: true
    environment:
      - DISPLAY=docker.for.mac.host.internal:0
    volumes:
      - .:/workspace
      - /tmp/.X11-unix:/tmp/.X11-unix
```

8. Launch Docker Desktop
9. Launch Docker container by executing `docker compose up -d` in the directory `brg.jar` exists with your terminal
10. Enter to the container by executing `docker compose exec container bash`
11. Now you are at `/workspace` in the container. You can see `brg.jar` in the directory.
12. Execute `java -jar brg.jar` in the container and you can see the simulator's GUI window. To stop the simulator, press `ctrl` + `c` in the terminal
13. To leave from the container, first type `exit` and press `Enter`. Second, execute  `docker compose down` after you see the host OS's terminal.

These instructions are based on macOS Ventura, but you may launch the existing simulator in other operating systems by similar way (I have not checked yet).

## References
1. https://www.cril.univ-artois.fr/en/software/brg/
2. https://gist.github.com/cschiewek/246a244ba23da8b9f0e7b11a68bf3285