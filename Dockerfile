FROM python:3.9.6

RUN apt-get update
RUN apt-get install -y \
    wget \
    gnupg2 \
    nvidia-cuda-toolkit
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN wget -qO - https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    cuda-cudart-11-4 \
    libcudnn8 \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /code

EXPOSE 8000
ENV PYHTONUNBUFFERED=1

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/libcuda1-460_460.73.01-0ubuntu1_amd64.deb
RUN ar -xvf libcuda1-460_460.73.01-0ubuntu1_amd64.deb && \
    tar -xvf data.tar.xz && \
    mv libcuda.so.1 /usr/local/nvidia/lib64/libcuda.so.1

COPY ./ /code
RUN python -m pip install --upgrade pip
RUN pip install -U --no-cache-dir -r /code/requirements.txt
RUN python -m decompress Citas_RN.zip /code/Citas_RN.h5
#RUN python -m notigram TOKEN=${TOKEN} Dockercompose Terminado UwUr
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]