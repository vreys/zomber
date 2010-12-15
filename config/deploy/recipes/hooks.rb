# Common hooks for all scenarios.
Capistrano::Configuration.instance(:must_exist).load do
  # after 'deploy:setup' do
  #   app.setup
  # end

  after "deploy:update", "deploy:cleanup"
  after "deploy:update_code", "symlinks:make"
end
