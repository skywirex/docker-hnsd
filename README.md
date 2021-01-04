## Supported Architectures

The architectures supported by this image are: 


| Architecture |  Tag   |
| :----------: | -------------- |
|    aarch64   | v1.0.0-aarch64 |
|    x86_64    | v1.0.0-x86_64   |

Check your board architecture using `arch` command. If you boards are not support, see **Building locally** to build your own docker images. 

## Usage

Check your port 53 free before using the below command.

Here are some example snippets to help you get started creating a container.

- Step 1: Get your local IP

```
IP=$(ifconfig eth0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
```

- Step 2: Create hnsd container (replace `<tag>` with appropriate tag above)

```
docker create \
  --name=hnsd \
  --net=host \
  --restart=unless-stopped \
  -it \
skywirex/hnsd:<tag> -r $IP:53
```

- Step 3: Run hnsd in Docker container

```
docker start hnsd
```

- Step 4: Check the hnsd container if it run correctly

```
docker ps -a
```

## Updating Info

Most of the images are static, versioned, and require an image update and container recreation to update the app inside. 

Below are the instructions for updating containers:

### Via Docker Run/Create

The example below for updating `hnsd` container

* Update the image: `docker pull skywirex/hnsd:<tag>`
* Stop the running container: `docker stop hnsd`
* Delete the container: `docker rm hnsd`
* Recreate a new container with the same docker create parameters as instructed
* Start the new container: `docker start hnsd`
* You can also remove the old dangling images: `docker image prune`

## Building locally

If you want to make local modifications to these images for development purposes or just to customize the logic:

```
git clone git://github.com/skywirex/docker-hnsd.git
cd docker-hnsd
VERSION=$(git ls-remote --tags --refs --sort="v:refname" git://github.com/handshake-org/hnsd.git | tail -n1 | sed 's/.*\///')
ARCH=$(arch)
docker build --no-cache --pull -t skywirex/hnsd:$VERSION-$ARCH .
```