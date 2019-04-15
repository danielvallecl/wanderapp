
# ASCII

for i in 0..255
  puts "This is the Integer " + "#{i}" + " and its string " + i.chr + " this is ASCII " + "#{i + 0x30}"
end

# To convert an ASCII file add either 0x30 (30 in Hex) or 48 in Decimal numbers.
# Sandbox moved
