FROM ruby:2.5.1-slim

RUN apt-get update -qq \
  && apt-get install -qqy \
    build-essential \
  && apt-get -qq clean \
  && apt-get -qq autoremove \
  && rm -rf /var/lib/apt/lists/*

# Setup Bundler
## The official ruby image sets these, but let's re-set them here
## in case the image changes the location on us
ENV BUNDLER_VERSION 1.16.1
ENV GEM_HOME /bundle
ENV GEM_PATH "${GEM_HOME}"
ENV BUNDLE_PATH "${GEM_HOME}"
ENV BUNDLE_BIN "${BUNDLE_PATH}/bin"
ENV PATH "${BUNDLE_BIN}:${PATH}"

RUN gem install bundler --version "$BUNDLER_VERSION"

ENV APP_HOME=/app
WORKDIR $APP_HOME

COPY . $APP_HOME/

# Install the gems in the image
RUN bundle check || bundle install --binstubs="$BUNDLE_BIN"

# Runs every time to check gems, and any other pre-check maintenance
ENTRYPOINT ["bin/entry.sh"]

# Default command, in case we aren't going through docker-compose
CMD ["/bin/bash"]
