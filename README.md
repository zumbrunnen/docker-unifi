# Docker Image for Ubiquiti Network's UniFi Controller

Installs the UniFi controller with MongoDB.

To start the controller, launch a container like this:

```
docker run -d --name unifi \
  -p 8081:8081 -p 8080:8080 -p 8443:8443 -p 8880:8880 -p 8843:8843 \
  zumbrunnen/unifi
```


For more information, visit their website: 

 * https://www.ubnt.com/
 * https://www.ubnt.com/enterprise/software/
 * https://community.ubnt.com/t5/custom/page/page-id/Blogs
