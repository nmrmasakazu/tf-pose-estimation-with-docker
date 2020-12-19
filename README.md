# tf-pose-estimation-with-docker



```bash
# if needed
git clone git@github.com:ildoonet/tf-pose-estimation.git -b 9aaf34708e9863eeab9685a7ec52a45f3b576e2d
# build
docker build -t tf-pose-estimation-with-docker .
# run
docker run -it -p 8888:8888 tf-pose-estimation-with-docker
# run interactively
docker run -it --rm tf-pose-estimation-with-docker bash
```



Thanks to

https://github.com/ildoonet/tf-pose-estimation





```
docker cp ee6a9d51df5f:/usr/src/app/tf_pose_estimation/estimate_image_sample.ipynb ./estimate_image_sample.ipynb
```

