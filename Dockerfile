FROM swipl:10.0.0

RUN apt-get update -y \
    && apt-get install -y \
        build-essential \
        ca-certificates \
        curl \
        flex \
        git \
        gnupg \
        meson \
        ninja-build \
        python-is-python3 \
        python3 \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install Serd
WORKDIR /usr/local/src
RUN git clone --branch v0.32.6 --depth 1 https://github.com/drobilla/serd.git
WORKDIR /usr/local/src/serd
RUN git submodule update --init --recursive
RUN meson setup build
WORKDIR /usr/local/src/serd/build
RUN meson configure \
    && meson compile \
    && meson install

# Install CTurtle
WORKDIR /usr/local/src
RUN git clone --branch v1.0.6 --depth 1 https://github.com/melgi/cturtle.git
WORKDIR /usr/local/src/cturtle
RUN make install

# Install EYE
WORKDIR /usr/local/src
RUN git clone --branch v20.0121.2250 --depth 1 https://github.com/eyereasoner/eye.git
WORKDIR /usr/local/src/eye
RUN ./install.sh && ln -s /usr/local/src/eye/eye.sh /usr/bin/eye

# Set up extractor
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm ci
COPY ontologies ontologies
COPY extract-website-data .
COPY rdfa2ttl .
COPY docker.sh .

ENTRYPOINT ["./docker.sh"]
