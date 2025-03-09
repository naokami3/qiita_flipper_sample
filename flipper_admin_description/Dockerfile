FROM ruby:3.3.7

RUN apt update -qq
RUN apt-get install -y curl
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get install -y \
    postgresql-client \
    yarn \
    vim

ENV LANG=C.UTF-8
RUN gem update --system && \
    gem install bundler
 
RUN mkdir /rails
WORKDIR /rails
COPY ./ /rails

COPY Gemfile /rails/Gemfile
COPY Gemfile.lock /rails/Gemfile.lock

RUN bundle install

EXPOSE 3000
CMD ["/bin/bash"]
