Capistrano::Configuration.instance(:must_exist).load do
  # These are set to the same structure in shared <=> current
  set :normal_symlinks, %w(
    config/database.yml
    bundle
    db/production.sqlite3
  ) unless exists?(:normal_symlinks)
  
  # Weird symlinks go somewhere else. Weird.
  set :weird_symlinks, {
    'pids'       => "tmp/pids",
    'posters'    => "public/images/posters",
    'thumbnails' => "public/images/thumbnails",
    'repos'      => "media/repos"
  } unless exists?(:weird_symlinks)

  namespace :symlinks do
    desc "Make all the damn symlinks in a single run"
    task :make, :roles => :app, :except => { :no_release => true } do
      commands = normal_symlinks.map do |path|
        "ln -nfs #{shared_path}/#{path} #{release_path}/#{path}"
      end

      commands += weird_symlinks.map do |from, to|
        "ln -nfs #{shared_path}/#{from} #{release_path}/#{to}"
      end

      run <<-CMD
        #{commands.join(" && ")}
      CMD
    end
  end
end
