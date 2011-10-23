# Taken from the cucumber-rails project.

module NavigationHelpers
  def path_to(page_name)
    case page_name
    when /the home\s?page/
      '/'

    when /^the workflows page$/
      '/workflows'
      
    when /^the "([^\"]*)" workflow page$/
      workflow_name = $1
      workflow_id = MyModels::Workflow.find({:name => workflow_name}).id
      "/workflows/#{workflow_id}"
      
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
