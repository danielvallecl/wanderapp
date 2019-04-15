
# A function that creates a file if does not exist, if it does append a message to with
# with a timestamp.

def writefile(filename, message)
  if !File.exists?(filename)
    logfile = File.new(filename, "w+")
    logfile.puts("This file was created at #{Time.now}")
    logfile.puts(message + "#{Time.now}")
    logfile.close
  else
    logfile = File.new(filename, "a")
    logfile.puts(message + " #{Time.now}")
    logfile.close
  end
end

# A function that reads files if they exist and outputs an error message if they don't.

def readfile(filename)
  if File.exists?(filename)
    logfile = File.new(filename, "r+")
    logfile.each do |line|
      puts line
    end
  else
    puts "The #{filename} does not exist."
  end
end

writefile("functiontest.txt", "I am testing the Writefile Function ")

readfile("test.txt")
readfile("functiontest.txt")
