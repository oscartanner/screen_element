FeatureMemory = Struct.new(:feature).new

Before do |scenario|
  begin
    @feature_name = scenario.scenario_outline.feature
  rescue
    @feature_name = scenario.feature
  end

  if ENV['PROFILE'] != 'saucelabs' || !FeatureMemory.feature.nil?
    if FeatureMemory.feature != @feature_name ||
       scenario.source_tag_names.include?('@wip')
      World.reinstall_app
    else
      World.launch_app unless FeatureMemory.feature.nil?
    end
  end
  FeatureMemory.feature = scenario.feature
end

After do |scenario|
  World.take_screenshot if scenario.failed?
  World.close_app
end

After('@reinstall_after') do
  World.reinstall_app
end
