require 'curb'
require 'httparty'
require 'open-uri'
require 'nokogiri'

SCHEDULER.every '30s', :first_in => 0 do |job|

doc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=RS-LBAL&srv=TCP_Connections", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
root = doc.root		#mark the top of the xml data

cpu = root.xpath("/NAGIOS/DATASOURCE[6]/ACT")# search for tags that match "act" there is only one set
cpu = cpu.to_s()	#convert the nodeset to a string
cpu2 = cpu[5...-6]	#strip the tag identifiers from each side of the value	
metervalue = cpu2.to_f / 1500 * 100	#convert to a float and as a percentage of 1500

servers = Array.new
servers << {name: "RS-LBAL - TCP", progress: metervalue}


send_event('LBAL-TCP', {title: "Load Balancer Conections", progress_items: servers})
end

