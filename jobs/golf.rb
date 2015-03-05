require 'curb'
require 'httparty'
require 'open-uri'
require 'nokogiri'

SCHEDULER.every '30s', :first_in => 0 do |job|
# Grab the raw XML

doc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=SQL2008R2&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
root = doc.root		#mark the top of the xml data

cpu = root.xpath("//ACT")# search for tags that match "act" there is only one set

cpu = cpu.to_s()	#convert the nodeset to a string
cpu2 = cpu[5...-6]	#strip the tag identifiers from each side of the value	
metervalue = cpu2.to_f	#convert to a float
	
send_event('golf',  value: metervalue)
end
