### docker-rinxter

Run:
	docker run -d -p 8999:8999 -name Rinxter seansummers/rinxter

Access your data:
	docker run -t -i -volumes-from Rinxter busybox sh -i

[DOCKER index](https://index.docker.io/u/seansummers/rinxter/)
