FROM debian:stable-slim

RUN apt update && apt install -y --no-install-recommends sudo curl tar ca-certificates && rm -rf /var/lib/apt/lists/*
RUN rm -rf /sbin/initctl && ln -s /sbin/initctl.distrib /sbin/initctl

WORKDIR /app

RUN ARCH=$(dpkg --print-architecture); \
    case "$ARCH" in \
        amd64) \
            TYPE=60 ;; \
        arm64) \
            TYPE=61 ;; \
        armhf|arm32) \
            TYPE=72 ;; \
        *) \
            echo "Unsupported architecture: $ARCH"; \
            exit 1 ;; \
    esac; \
    LINK="https://assets.coreservice.io/public/package/$TYPE/app-market-gaga-pro/1.0.4/app-market-gaga-pro-1_0_4.tar.gz"; \
    FILENAME="app-linux-$ARCH.tar.gz"; \
    curl -L -o $FILENAME $LINK; \
    tar -xzvf $FILENAME; \
    rm -f $FILENAME; \
    DIR_NAME=$(ls -d apphub-linux*); \
    echo "Extracted directory: $DIR_NAME"; \
    mv $DIR_NAME apphub-linux

COPY . .

RUN chmod 777 ./gaganode.sh
CMD ./gaganode.sh; sleep infinity