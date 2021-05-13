FROM docker:stable as gem-builder
RUN apk update  && apk add --no-cache ruby ruby-dev git make gcc libc-dev
RUN mkdir /build_gem
WORKDIR /build_gem
COPY . /build_gem
RUN gem install rake bundler && \
    rake build && \
    rm /usr/bin/erb && \
    gem install pkg/*.gem

FROM docker:stable
COPY --from=gem-builder /usr/lib/ruby/gems /usr/lib/ruby/gems
COPY --from=gem-builder /usr/bin/popito /usr/bin/popito
RUN apk update  && apk add --no-cache curl ruby  && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl