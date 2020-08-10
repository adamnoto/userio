# UserIO

A user microservice. Stack used:

- Mostly vanilla Rails
- React (on some page)
- Formik + Fluent UI (on some part)
- Tailwind CSS (overall layouting and controls)

The profile page demonstrates React + Formik + FluentUI, where other pages are server-rendered. TailwindCSS is used to help style the overall layout and look-and-feel.

## Setup

1. Clone the repository
1. Install the required software with version recommended to match closely:
   - Ruby 2.6.6
   - NodeJS 13.14.0
   - Yarn 1.22.4
   - PostgreSQL 10 or higher
   - Google Chrome (to run feature specs)
1. Run:

   ```
   $ gem install bundler
   $ bundle install
   $ bundle exec rails db:migrate
   ```

1. To run the server:

   ```
   $ rails server
   ```

   To stop it, just press Ctrl + C

## Strict requirements

- [x] As a user, I can visit sign up page and sign up with my email (with valid format and unique in database) and password (with confirmation and at least eight characters).
- [x] When I sign up successfully, I would see my profile page.
- [x] When I sign up successfully, I would receive a welcome email.
- [x] When I sign up incorrectly, I would see error message in sign up page.
- [x] As a user, I can edit my username and password in profile page. I can also see my email in the page but I can not edit it.
- [x] When I first time entering the page, my username would be my email prefixing, e.g. (email is “user@example.com” , username would be “user”)
- [x] When I edit my username, it should contain at least five characters. (Default username does not has this limitation)
- [x] As a user, I can log out the system.
- [x] When I log out, I would see the login page.
- [x] As a user, I can visit login page and login with my email and password.
- [x] As a user, I can visit login page and click “forgot password” if I forgot my password.
- [x] When I visit forgot password page, I can fill my email and ask the system to send reset password email.
- [x] As a user, I can visit reset password page from the link inside reset password email and reset my password (with confirmation and at least eight characters).
- [x] The link should be unique and only valid within six hours.
