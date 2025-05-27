FROM ubuntu:latest
# See airflow quickstart guide for more info https://airflow.apache.org/docs/apache-airflow/stable/start.html
ARG airflow_home=~/airflow
ARG airflow_version=3.0.1
ARG python_version=3.12
ARG constraint_url="https://raw.githubusercontent.com/apache/airflow/constraints-${airflow_version}/constraints-${python_version}.txt"
ARG user=afuser
ARG airflow_venv=/home/${user}/.airflow-venv


# Update
RUN apt update -y

# Upgrade
RUN apt upgrade -y

# Install OS dependencies
RUN apt install curl -y

# Create a user
RUN useradd ${user}

# Change to user
USER ${user}

# Working directory
WORKDIR /home/${user}

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# Create virtual environment
RUN ~/.local/bin/uv venv --python ${python_version} ${airflow_venv}

# Activate environment and install airflow
RUN ["bash", "-c", "source ${airflow_venv}/bin/activate && AIRFLOW_HOME=${airflow_home} && ~/.local/bin/uv pip install \"apache-airflow==${airflow_version}\" --constraint \"${constraint_url}\""]

# Load virtual environment and start airflow
CMD ["bash" , "-c", "source ~/.airflow-venv/bin/activate && airflow standalone"]