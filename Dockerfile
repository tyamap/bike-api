FROM ruby:2.6.4

RUN apt-get update -qq && \
    apt-get install -y build-essential \ 
                       libpq-dev \        
                       nodejs

# 作業ディレクトリの作成、設定
RUN mkdir /app_name 
# 作業ディレクトリ名をAPP_ROOTに割り当てて、以下$APP_ROOTで参照
ENV APP_ROOT /app_name 
WORKDIR $APP_ROOT

# ホスト側（ローカル）のGemfileを追加¥
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock

# Gemfileのbundle install
RUN bundle install
ADD . $APP_ROOT