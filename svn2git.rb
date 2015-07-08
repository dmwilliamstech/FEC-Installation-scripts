
## @repos is a map of repo names and locations
@repos = { "repo1" => 82, "repo2" => 94, "repo3" => 58 }

## now loop through the above array

@repos.each do|name,location|
  puts "#{name}: #{location}"
  puts "Cloning repo #{name}"
	  if File.exist?('users.txt')
	  system "git svn clone $i --authors-file=users.txt --no-metadata -s ."
	else
		puts "No users.txt present"
	end
end
