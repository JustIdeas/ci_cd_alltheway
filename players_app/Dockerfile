FROM golang:1.13-stretch AS build

WORKDIR /src/
COPY *.go /src/

RUN CGO_ENABLED=0 go build -o /bin/players-app

FROM alpine:3.7
COPY --from=build /bin/players-app /bin/players-app
ENTRYPOINT ["/bin/players-app"]