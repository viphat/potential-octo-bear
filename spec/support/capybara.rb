
Capybara.asset_host = 'http://localhost:3000'

# Dung Google Chrome
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.current_driver = :selenium