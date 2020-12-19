FROM python:3.6

WORKDIR /usr/src/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        swig \
        ffmpeg \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./tf-pose-estimation ./tf-pose-estimation

COPY ./estimate_image_sample.ipynb ./tf-pose-estimation/

RUN pip install --upgrade pip \
    && pip install tensorflow==1.14 \
    && pip install opencv-python \
    && pip install protobuf \
    && pip install pandas \
    && pip install openpyxl \
    && pip install jupyter \
    && pip install -r ./tf-pose-estimation/requirements.txt \
    && bash ./tf-pose-estimation/models/graph/cmu/download.sh \
    && cd ./tf-pose-estimation/tf_pose/pafprocess/ \
    && swig -python -c++ pafprocess.i && python3 setup.py build_ext --inplace \
    && cd /usr/src/app \

EXPOSE 8888

CMD jupyter notebook --ip=0.0.0.0 --allow-root
