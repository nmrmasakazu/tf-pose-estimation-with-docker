FROM python:3.6

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        swig \
        ffmpeg \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./tf-pose-estimation ./

COPY ./additionals ./

RUN pip install --upgrade pip \
    && pip install -r ./additional-requirements.txt \
    && pip install -r ./requirements.txt \
    && bash ./models/graph/cmu/download.sh \
    && cd ./tf_pose/pafprocess/ \
    && swig -python -c++ pafprocess.i && python3 setup.py build_ext --inplace \
    && cd /usr/src/app

EXPOSE 8888

CMD jupyter notebook --ip=0.0.0.0 --allow-root
