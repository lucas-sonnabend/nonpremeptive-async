# Async pitfalls in python - non preemptive event loop

This a simple async webserver to demonstrate a pitfall of the python async framework: non-preemptive scheduling.

The blog post explaining this is here. (still to do).

## How to run the webserver

This has been run on ubuntu 20.04.

### Prerequesites

You will need python >= 3.8, poetry and curl

### Install the dependencies
```
cd example_webserver
poetry install
```

### Run the webserver
```
cd example_webserver
poetry run uvicorn example:app
```

### Run the health check script
```
./health_checker.sh
```

### Simulate a long-running request
```
curl localhost:8000/processing
```