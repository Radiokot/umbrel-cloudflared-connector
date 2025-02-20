# get the cloudflared image
FROM cloudflare/cloudflared:2025.2.0 as cloudflared

# take the alpine image
FROM alpine:3.18.4

# update nc and killall to support the required options,
# install tini for proper signal forwarding
RUN apk add --update --no-cache tini netcat-openbsd psmisc

# copy the connector binary from the cloudflared image
COPY --from=cloudflared /usr/local/bin/cloudflared ./cloudflared

# copy the control scripts
COPY accept.sh default-response process.sh control-loop.sh ./

# expose the control port
EXPOSE 8018

# make tiny the entrypoint and make it to kill the process group
ENTRYPOINT ["/sbin/tini", "-g", "--"]

# run the control loop
CMD ["sh", "control-loop.sh"]

