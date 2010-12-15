def parse_config(file)
  template = File.read(file)
  return ERB.new(template).result(binding)
end

def generate_config(local_file, remote_file)
  temp_file = File.join('/', 'tmp', File.basename(local_file))
  buffer    = parse_config(local_file)
  
  File.open(temp_file, 'w+') { |f| f << buffer }
  
  upload temp_file, remote_file, :via => :scp

  File.unlink(temp_file)
end 
