FROM python:3.9.6

RUN apt-get update
RUN apt-get install -y wget gnupg2
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /code

EXPOSE 8000
ENV PYHTONUNBUFFERED=1

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/libcuda1-460_460.73.01-0ubuntu1_amd64.deb
RUN ar -xvf libcuda1-460_460.73.01-0ubuntu1_amd64.deb
RUN tar -xvf data.tar.xz
RUN mv libcuda.so.1 /usr/local/nvidia/lib64/libcuda.so.1

COPY ./ /code
RUN python -m pip install --upgrade pip
RUN pip install -U --no-cache-dir -r /code/requirements.txt
RUN python -m decompress Citas_RN.zip /code/Citas_RN.h5
#RUN python -m notigram TOKEN=${TOKEN} Dockercompose Terminado UwUr
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]