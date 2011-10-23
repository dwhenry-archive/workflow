When /^I create a new workflow "([^"]*)"$/ do |workflow_name|
  click_on 'New Workflow'
  fill_in 'Name', :with => workflow_name
  fill_in 'Description', :with => "Description For #{workflow_name}"
  click_on 'Create'
end

Then /^I should see workflow for "([^"]*)"$/ do |workflow_name|
  page.should have_css('.row.workflow', :text => workflow_name)
end

Given /^I have a workflow "([^"]*)"$/ do |workflow_name|
  MyModels::Workflow.create({:name => workflow_name, :description => workflow_name})
end

When /^I view workflow "([^"]*)"$/ do |workflow_name|
  click_on workflow_name
end

When /^I rename the workflow to "([^"]*)"$/ do |workflow_name|
  click_on 'Edit Workflow'
  fill_in 'Name', :with => workflow_name
  click_on 'Update'
end