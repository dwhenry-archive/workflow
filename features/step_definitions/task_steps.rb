When /^I add a new task "([^"]*)" with definition:$/ do |task_name, table|
  click_on 'Add Task'
  fill_in 'Name', :with => task_name
  definitions = table.hashes.map{|t| t['Deinition']}.join("\n")
  fill_in 'Definition', :with => definitions
  click_on 'Create'
end

Then /^I workflow "([^"]*)" should have tasks:$/ do |workflow, table|
  Then %Q{I should see workflow for "#{workflow}"}
  table.hashes.each do |row|
    page.should have_css('.task', :text => row['Task'])
  end
end