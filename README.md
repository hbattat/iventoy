iVentoy Dockerized Server
=

Current version is the latest from [official site](https://github.com/ventoy/PXE/releases): v1.0.20

To run:
-
Clone the repo:
```
git clone https://github.com/hbattat/iventoy
```

Build Docker image:
```
cd iventoy
docker build -t iventoy-image .
```

Create a direcotry for your ISO files or use an existing one (skip if you have a dir already):
```
mkdir /path/to/your/iso
```

Run Docker with the image you built:
```
 docker run -d --privileged -p 69:69 -p 67:67 -p 16000:16000 -p 26000:26000 -p 10809:10809  -v /path/to/your/iso:/iventoy/iso --name iventoy iventoy-image
```
