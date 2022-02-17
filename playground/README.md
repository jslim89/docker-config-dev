# Development playground

Sometimes, we attend training session that require us to install certain library.
We don't want to mess up our local machine. This is a good way to work on the
training session in a container

## Usage

```
docker-compose -f ubuntu.yml up -d
docker exec -it playground-ubuntu bash
```
