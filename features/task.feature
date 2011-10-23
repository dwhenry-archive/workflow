Feature: Tasks
  Background:
    Given I have a workflow "Test Workflow"
    And I am on the "Test Workflow" workflow page
   
  @wip
  Scenario: Add a task
    When I add a new task "New Task" with definition:
      | Definition        |
      | INITIALISE at 7pm |
    Then I workflow "Test Workflow" should have tasks:
      | Tasks    |
      | New Task |