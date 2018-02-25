require 'selenium-webdriver'
require 'test-unit'

class SampleTest < Test::Unit::TestCase

  def setup
    # Set webdriver to Firefox
    @driver=Selenium::WebDriver.for :firefox
    # Maximize window
    #@driver.manage.window.maximize
    # Open the following URL
    @driver.get "https://rubygems.org/gems/selenium-webdriver/versions/2.52.0"
  end

  def test_search_one
    # Input text into the search box
    searchBarTextbox = @driver.find_element(:id, 'query')
    searchBarTextbox.send_keys('Hello this is a good query, yes.')

    # Click the search button
    searchButton = @driver.find_element(:id, 'search_submit')
    searchButton.click

    # Wait until the text element on the page appears
    wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    wait.until {@driver.find_element(:link_text => "search") }

    # Define the text element
    searchTitleText = @driver.find_element(:class, 't-link--black')
    isSearchTitleTextDisplayed = searchTitleText.displayed?

    # Assert tests
    assert_equal(true, isSearchTitleTextDisplayed, 'The Search Title Text is Displayed')
  end

  def test_search_two
    gemfileValueText = @driver.find_element(:id, 'gemfile_text').attribute("value")
    installValueText = @driver.find_element(:id, 'install_text').attribute("value")

    assert_equal("gem 'selenium-webdriver', '~> 2.52'", gemfileValueText, 'The Gemfile Value Text is Displayed')
    assert_equal("gem install selenium-webdriver -v 2.52.0", installValueText, 'The Install Value Text is Displayed')
  end

  def test_search_three
    titleLink = @driver.find_element(:xpath, "//a[@href='/gems/selenium-webdriver/versions/2.52.0']").text

    assert_equal('selenium-webdriver', titleLink, 'The Title Text is Displayed')
  end

  def test_search_four
    formCharset = @driver.find_element(:xpath, "//form[@method='get']").attribute("accept-charset")

    assert_equal('UTF-8', formCharset, 'The Form Charset is OK')
  end

  def teardown
    # Exit test
    @driver.quit
  end


end
