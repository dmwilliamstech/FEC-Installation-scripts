
## @repos is a map of repo names and locations
@repos = { "repo1" => 82, "repo2" => 94, "repo3" => 58 }

## now loop through the above array
echo """svn log -q | awk -F \'|\' \'/^r/ {sub("^ ", "", $2); sub(" \$", "", \$2)\; print \$2" = "\$2" <"\$2">"}' | sort -u > users.txt"""

@repos.each do|name,location|
  puts "#{name}: #{location}"
  puts "Cloning repo #{name}"
  system "git svn clone $i --authors-file=users.txt --no-metadata -s ."
end
