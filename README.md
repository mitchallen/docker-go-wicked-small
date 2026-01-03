docker-go-wicked-small
==

### Usage

1. Build it

```sh
docker build -t tiny-go .
```

2. Run it

```sh
docker run --rm tiny-go
```

3. Check the size

```sh
docker images | grep tiny-go
docker image inspect tiny-go --format='{{.Size}}'
docker image inspect tiny-go --format='{{.RepoTags}} => {{.Size}}'
```

Note: `docker image inspect` shows the raw bytes while `docker images` includes manifest overhead for multi-platform builds, so the sizes may differ.

* * *

### Optional Variant: HTTPS-capable (Distroless)

If you ever need HTTPS or root certs, swap the runtime stage:

```sh
FROM gcr.io/distroless/static
COPY --from=builder /app/app /app
ENTRYPOINT ["/app"]
```