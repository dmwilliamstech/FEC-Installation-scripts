
## @repos is a map of repo names and locations
@repos = { "repo1" => 82, "repo2" => 94, "repo3" => 58 }

## now loop through the above array

@repos.each do|name,location|
	if File.exist?('users.txt')
	  puts "#{name}: #{location}"
	  puts "Cloning repo #{name}"
	  system "git svn clone $i --authors-file=users.txt --no-metadata -s ."
	  system "cp -Rf .git/refs/remotes/origin/tags/* .git/refs/tags/"
	  system "rm -Rf .git/refs/remotes/origin/tags"
	  syste, "cp -Rf .git/refs/remotes/* .git/refs/heads/"
	  system "rm -Rf .git/refs/remotes"
	  system "git remote add master git@localhost:gitlab-users/#{name}.git"
	  system "git push --set-upstream gitlab master"
	else
		puts "No users.txt present"
	end
end
