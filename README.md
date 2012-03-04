# creepy_crawler

A website scraping framework.  Creepy crawler is ideal for implementing different crawling rules for each site you intend to spider/scrape.  It is especially good for small incremental crawling, such as in a [heroku hourly cron job][herokucron].

This gem requires ActiveRecord version 3.0.0 or greater.

This is based on the spidering logic I originally built for [Compare Vinyl][comparevinyl].

## Example Usage


## Install 

``` ruby
## Add the following to you Gemfile
gem 'creepy_crawler'
## Run this
bundle install
```


[comparevinyl]: http://www.comparevinyl.com/
[herokucron]: http://devcenter.heroku.com/articles/cron