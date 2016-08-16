# Adobe AIR inside docker
Want to run an Adobe AIR application?! I don't know why you would! Incase you do, feel free to use this broken-soul-of-a container to do it in.

The path to the installer binary is `/usr/local/bin/air-installer` or just `air-installer` for your installation needs.

Here is a barebones example of a `Dockerfile` you might make:
```
USE nucleardreamer/air-docker
RUN air-install -silent -eulaAccepted /path/to/a/probably/useless/app.air
```

If you are trying to run headless (meaning no interface for the install), you can use `xvfb` to fake your X11 server socket because adobe is stupid as hell. This will start an virtual frame buffer for the installer to use:

```
ENV DISPLAY=:0
RUN apt-get update && apt-get install -y xvfb && \
    Xvfb :0 -screen 0 666x666x16 > /dev/null 2>&1
RUN air-install -silent -eulaAccepted /path/to/a/probably/useless/app.air
```

## UI in AIR

The most common use case would be to extend this bad boy to `USE` this bad boy in another docker file, like you can see in this [infrared touch frame](https://github.com/nucleardreamer/pqmt-air-docker) project.

One common way to share your X server is to just mount your X's UNIX socket as a volume.

An example would be, if your `DISPLAY` variable was the default `:0` or `localhost:0`, you could do a `docker run -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY`, which will share all the X sockets you have (in the case of multiple monitors).

Good luck. I really hope nobody actually needs to use this repository!
