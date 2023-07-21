# Authors: <yitong.bai@qq.com>

$version = "v1.0.0"
$local_image = "registry.arksec.cn/virgo/releases/v1/amd64/virgo-mvp:latest"
$remote_repos = "docker.io/arksec/fast-scanner",
                "registry.cn-beijing.aliyuncs.com/arksecurity/fast-scanner",
                "registry.cn-shanghai.aliyuncs.com/arksecurity/fast-scanner",
                "registry.cn-hangzhou.aliyuncs.com/arksecurity/fast-scanner",
                "registry.cn-huhehaote.aliyuncs.com/arksecurity/fast-scanner",
                "registry.ap-northeast-1.aliyuncs.com/arksecurity/fast-scanner",
                "registry.us-west-1.aliyuncs.com/arksecurity/fast-scanner",
                "registry.me-east-1.aliyuncs.com/arksecurity/fast-scanner"

docker pull $local_image

foreach($remote_repo in $remote_repos){
  $remote_image = "${remote_repo}:${version}"
  docker tag $local_image $remote_image
  docker push $remote_image
}
