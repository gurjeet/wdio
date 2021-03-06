FROM alpine:3.9

RUN apk --no-cache add \
    nodejs \
    npm \
    ffmpeg \
  && npm install -g \
    npm@latest \
    @wdio/cli@^5.6.4 \
    @wdio/local-runner@^5.6.4 \
    @wdio/mocha-framework@^5.6.4 \
    @wdio/spec-reporter@^5.6.4 \
    @wdio/sync@^5.6.4 \
    chai@^4.2.0 \
    mailhog@^3.0.0 \
    uuid@^3.3.2 \
    wdio-screen-commands@^1.0.0 \
    webdriverio@^5.6.4 \
  # Clean up obsolete files:
  && rm -rf \
    /tmp/* \
    /root/.npm

# Set NODE_PATH to be able to require globally installed packages:
ENV NODE_PATH=/usr/lib/node_modules

# Avoid permission issues with host mounts by assigning a user/group with
# uid/gid 1000 (usually the ID of the first user account on GNU/Linux):
RUN adduser -D -u 1000 wdio

USER wdio

WORKDIR /home/wdio

COPY bin/wait-for.sh /usr/local/bin/wait-for

ENTRYPOINT ["wait-for", "--", "wdio"]
