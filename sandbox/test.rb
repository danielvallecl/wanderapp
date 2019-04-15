
# Creating Logs

# If a file does not exist:
if !File.exists?("write.txt")

  myfile = File.new("write.txt", "w+")
  myfile.puts("LOG STARTED @ #{Time.now}")
  myfile.close

else

  myfile = File.new("write.txt", "a")

  myfile.puts("This is line to be appended - #{Time.now}")
  myfile.close

end

    myfile = File.new("write.txt", "r")
    myfile.each do |l|
      print l
    end
