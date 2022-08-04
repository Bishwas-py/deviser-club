FROM ruby:2.7.0-alpine

RUN apk add --update --no-cache build-base imagemagick6 imagemagick6-c++ \
    imagemagick6-dev imagemagick6-libs \
    postgresql-client postgresql-dev \
    tzdata

WORKDIR /app

COPY . /app/

ENV BUNDLE_PATH /gems

#RUN yarn install
RUN bundle install

ENTRYPOINT ["bundle", "exec", "rails"]
CMD ["server", "--binding", "0.0.0.0", "--port", "3000"]

EXPOSE 3000