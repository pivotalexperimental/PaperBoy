When(/^I select the first article$/) do
    sleep 1
    touch "view:'UILabel' marked:'Pivotal Labs: Why it works'"
    sleep 1
end

Then(/^I should be able to view the issue's contents$/) do
  check_element_exists "view:'UIWebView'"
end