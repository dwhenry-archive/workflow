Feature: Workflow

  Scenario: Create a new workflow
    Given I am on the workflows page
    When I create a new workflow "Test Workflow"
    Then I should see workflow for "Test Workflow"
    
  Scenario: Navigate to an existing workflow
    Given I have a workflow "Test Workflow"
    And I am on the workflows page
    When I view workflow "Test Workflow"
    Then I should see workflow for "Test Workflow"
    
  @wip
  Scenario: Edit an existing workflow
    Given I have a workflow "Test Workflow"
    And I am on the "Test Workflow" workflow page
    When I rename the workflow to "Real Workflow"
    Then I should see workflow for "Real Workflow"