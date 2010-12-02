namespace :repository do
  task :index => [:environment] do
    Repository.index!
  end
end
