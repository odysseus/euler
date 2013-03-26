def exec n
	svdir = Dir::pwd
	cd "#{`echo $HOME`.strip}/Desktop"
	f = open("rbeuler_exec.txt", "w")
	(1..n).each do |i|
		f.write("puts \"Project Euler Problem #{i}:      \#{eu#{i}.to_hr}\"\n")
	end
	f.close
	cd svdir
end
def ln; puts ""; end
def cd path
	Dir.chdir(path)
end
