# Quiply Rails [![Build Status](https://travis-ci.org/stephancom/quiply-rails.svg?branch=master)](https://travis-ci.org/stephancom/quiply-rails) [![Maintainability](https://api.codeclimate.com/v1/badges/b49cc671938dcc04f0c0/maintainability)](https://codeclimate.com/github/stephancom/quiply-rails/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/b49cc671938dcc04f0c0/test_coverage)](https://codeclimate.com/github/stephancom/quiply-rails/test_coverage) [![Deploy to Heroku](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

### Quip cohort challenge

## Spec

Group users into week long cohorts based on the user's signup date. For each cohort, calculate:

- The number of *distinct users* (orderers) who ordered in the first 7 days *after signup*. Older cohorts will have more buckets: i.e. 0-7 days, 7-14 days, 14-21 days, etc...
- The number of *distinct users* who ordered for the first time in each bucket


### Output

Please output an html table or CSV that looks something like this. It should include Cohorts, # users, & entries for each bucket.

*(this is only an example. this is NOT real data)*

```
|  Cohort     |  Users      |  0-7 days   | 7-14 days  | 14-21 days  | ....
|-------------|-------------|-------------|------------|-------------|-------------
| 7/1-7/7     | 300 users   | 25% orderers (75)<br>25% 1st time (75) |             |            |
| 6/24-6/30   | 200 users   | 15% orderers (30)<br>15% 1st time (30) | 5% orderers (10)<br>1.5% 1st time (3) |            | 
| 6/17-6/23   | 100 users   | 30% orderers (30)<br>30% 1st time (30) | 10% orderers (10)<br>3% 1st time (3) |  15% orderers (15)<br>5% 1st time (5) | 
| ... | ... | ... | ... | ... | ...
```

### Data You Have

#### User
* id
* created_at

#### Orders
* id
* user_id
* created_at
* order_num **note: this field is 1-indexed**

### Notes

* Data ends in July '13
* You should default to 8 weeks back worth of cohorts, would be nice if this is customizable (via parameter or form or something)
* All dates are stored in UTC, but occured in PDT. Bonus points for handling that correctly.

### *need clarification*

* do order numbers count up from 1 for a given user? assuming yes.
* not clear what "weeks back worth of cohorts" - assuming this is columns of order weeks, rather than history back of cohort groups, mainly because it seems like you wouldn't want unlimited columns, though it sounds like you're asking to limit the number of rows?
* I'm leaving cells blank where there are no sales - seems more readable


# build notes

This application was generated with the [rails_apps_composer](https://github.com/RailsApps/rails_apps_composer) gem
provided by the [RailsApps Project](http://railsapps.github.io/).

Rails Composer is supported by developers who purchase our RailsApps tutorials.

Problems? Issues?
-----------

Need help? Ask on Stack Overflow with the tag 'railsapps.'

Your application contains diagnostics in the README file. Please provide a copy of the README file when reporting any issues.

If the application doesn't work as expected, please [report an issue](https://github.com/RailsApps/rails_apps_composer/issues)
and include the diagnostics.

Ruby on Rails
-------------

This application requires:

- Ruby 2.3.0
- Rails 5.0.7.1

Learn more about [Installing Rails](http://railsapps.github.io/installing-rails.html).

Getting Started
---------------

Documentation and Support
-------------------------

Issues
-------------

Similar Projects
----------------

Contributing
------------

Credits
-------

License
-------
