require "capybara/rspec"
require "capybara/apparition"

Capybara.server_port = 23456

Capybara.register_driver :apparition do |app|
  Capybara::Apparition::Driver.new app,
    headless: true,
    debug: true,
    browser_options: {
      "no-sandbox" => true,
      "disable-dev-shm-usage" => true,
    }
end

Capybara.default_driver = :apparition
Capybara.javascript_driver = :apparition

def session_port
  Capybara.current_session.server.port
end
