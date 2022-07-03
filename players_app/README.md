# Players APP

A simple web server where users can track how many games players have won.

This code was extracted from [Learn Go With Tests](https://quii.gitbook.io/learn-go-with-tests/build-an-application/http-server).

## Getting Started

### Prerequisites

- [Golang](http://golang.org/) (>1.10)
- [GNU Make](https://www.gnu.org/software/make/)
- [Docker](http://docker.com)

### Running locally

```bash
make run
```

## Running tests and check coverage

```bash
make test
```

## Deployment

### Build

```bash
make image VERSION=x.x.x
```

### Tag and publish image

```bash
make pubish VERSION=x.x.x
```

### Run registry image locally

```bash
make run-docker VERSION=x.x.x
```

### Endpoints


- `GET /players/{name}` should return a number indicating the total number of wins
- `POST /players/{name}` should record a win for that name, incrementing for every subsequent `POST`