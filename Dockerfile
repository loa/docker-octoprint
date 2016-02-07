FROM resin/rpi-raspbian:jessie

RUN apt-get update && \
    apt-get install -y python python-dev python-pip python-virtualenv --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y imagemagick libav-tools cura-engine && \
    rm -rf /var/lib/apt/lists/*

ENV OCTOPRINT_DOWNLOAD_URL=https://github.com/foosel/OctoPrint/archive/dedadbc9ac0305799e94ae279d3bca131629c4c5.zip \
    OCTOPRINT_DOWNLOAD_SHA1=39dbb3f2446be0d07aee533fa14a6a1b7db738c5 \
    OCTOPRINT_GITSHA=dedadbc9ac0305799e94ae279d3bca131629c4c5

RUN set -x; buildDeps='curl ca-certificates build-essential libyaml-dev unzip'; \
    apt-get update && \
    apt-get install -y $buildDeps && \
    curl -sSL "$OCTOPRINT_DOWNLOAD_URL" -o octoprint.zip && \
    echo "$OCTOPRINT_DOWNLOAD_SHA1 *octoprint.zip" | sha1sum -c - && \
    unzip octoprint.zip && \
    mv OctoPrint-${OCTOPRINT_GITSHA} /srv/octoprint && \
    rm octoprint.zip && \
    cd /srv/octoprint && \
    python setup.py install && \
    pip install pybonjour && \
    apt-get purge -y --auto-remove $buildDeps && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/octoprint

ENTRYPOINT [ "octoprint", "--iknowwhatimdoing" ]
