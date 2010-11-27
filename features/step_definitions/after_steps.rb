After do
  serials_dirpath = Rails.root.join('tmp', 'serials')
  FileUtils.rm_r(Rails.root.join('tmp', 'serials')) if File.exists?(serials_dirpath)
end
