# ATM Project description

Simple console banking system.
There is v2.0 of test task for #pivorak Summer Course 2018
After theory part of the course, I learned so much and now improve my test task code using main skills which I got on the first part of the course.

# Deployment

- Clone repo: `git clone git@github.com:skrix/pivorak-bank.git`
- Go to project dir: `cd pivorak-bank`
- Install bundler: `gem install bundler`
- Install gems: `bundle install`
- Go to lib: `cd pivorak-bank/lib`
- Run app: `ruby atm.rb [config.yml optional yaml file with users data]` or `ruby atm.rb`

# Answers to test task submission:
When making decisions about your code, keep in mind that the bank owners may request certain changes in functionality in the future. Can your code design allow such changes easily?
 - Yes, my program can be scaled.

What do possible security issues you see in the current app design? What changes would you recommend to improve the security of the app?
 - I think that there are much more professional tips to give security for an app. But I didn't use all S.O.L.I.D. principles so, this app is badly architectured.

In your opinion, what could prevent the bank from integrating the current app into their production systems right now?
 - Really? As for me, I write really ugly code, because of lack of skills, so there are many reasons.
