When(/^I should see the issues popover$/) do
  check_element_exists "view:'_UIPopoverView'"
end

Then(/^I should see "(.*?)" in issues popover$/) do |text|
  check_element_exists "view:'_UIPopoverView' view:'UIView' label marked:'#{text}'"
end

When(/^I select the first issue$/) do
    sleep 1
    touch "view:'UILabel' marked:'Pivotal Culture'"
    sleep 1
end

When(/^I wait for the download to finish$/) do
    app_has_finished_downloading
end

Then(/^I should see that the issue becomes available$/) do
    app_has_finished_downloading
end

def app_has_finished_downloading
  wait_for_element_to_exist "view:'UITableViewLabel' first marked:'available'"
end