# Airflow Basic
An example bringing up airflow for development

# Pre-requisites

- [Docker](https://www.docker.com/) or [Podman](https://podman.io/)

## Bring up

With podman
```shell
podman compose up
```

With docker
```shell
docker compose up
```

At this point airflow should be running and listenting [localhos:8080](https://localhost:8080) see `admin` credentiales generated in `airflow/simple_auth_manager_passwords.json.generated`.

## Deploy dags to composer
[Google Cloud Composer](https://cloud.google.com/composer?hl=en) is a service that manages Airflow for you and dags are stored in a bucket and can be easily "deployed" using [gcloud cli](https://cloud.google.com/cli?hl=en)

```shell
gcloud storage cp ./airflow/dags/*.py gs://path/to/bucket
```

## Open container shell
```shell
airflow-basic % docker exec -it airflow_basic "/bin/bash"
```