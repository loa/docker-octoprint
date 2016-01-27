# OctoPrint

```
docker run \
    -d \
    -p 5000:5000 \
    -v $PWD/octoprint_config:/root/.octoprint \
    --device=/dev/ttyUSB0 \
    --name octoprint serialise/octoprint
```
