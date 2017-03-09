FeatureMemory = Struct.new(:feature).new

Before do |scenario|
  begin
    @feature_name = scenario.scenario_outline.feature.name
  rescue
    @feature_name = scenario.feature.name
  end

  if ENV['PROFILE'] != 'saucelabs'
    # No need for launch in the first execution
    # Appium does the launch when the driver is created
    World.launch_app unless FeatureMemory.feature.nil?

    # Reinstall app before every new scenario and tag @reinstall_before
    if FeatureMemory.feature != @feature_name ||
       scenario.source_tag_names.include?('@reinstall_before')
      World.reinstall_app
    end
  end
  FeatureMemory.feature = @feature_name
end

After do |scenario|
  embed World.take_screenshot, 'image/png' if scenario.failed?
  World.close_app
end

After('@reinstall_after') do
  World.reinstall_app
end
