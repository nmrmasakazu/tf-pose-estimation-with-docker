# tf-pose-estimation-with-docker

tf-pose-estimation directory is from https://github.com/ildoonet/tf-pose-estimation (Thanks)

```bash
# if needed
git clone git@github.com:ildoonet/tf-pose-estimation.git -b 9aaf34708e9863eeab9685a7ec52a45f3b576e2d
# build
docker build -t tf-pose-estimation-with-docker .
# run
docker run -it -p 8888:8888 tf-pose-estimation-with-docker
```





```bash
# When you analyzed
docker cp <CONTAINER ID>:/usr/src/app/tf_pose_estimation/outputs/ ./outputs/
```

