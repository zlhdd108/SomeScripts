FROM alpine as builder
ENV base=https://github.com/FKPYW/SomeScripts/releases/download/latest/
ENV file=openwrt-x86-64-generic-rootfs.tar.gz
RUN wget -q "$base$file"
RUN mkdir /rootfs && tar xf "$file" -C /rootfs

FROM scratch
COPY --from=builder /rootfs/ /
CMD ["/bin/sh"]
