
require 'httparty'
require 'open-uri'
require 'nokogiri'

SCHEDULER.every '60s', :first_in => 0 do |job|

doc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
roota = doc.root		#mark the top of the xml data
cpu1 = roota.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue7 = cpu1.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docb = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet2&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootb = docb.root		#mark the top of the xml data
cpu2 = rootb.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue8 = cpu2.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet3&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootc = docc.root		#mark the top of the xml data
cpu3 = rootc.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue9 = cpu3.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docd = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=RS-WEB4&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootd = docd.root		#mark the top of the xml data
cpu4 = rootd.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue10 = cpu4.to_s()[5...-6].to_f	#convert the nodeset to a readable value

doce = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=kilo&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
roote = doce.root		#mark the top of the xml data
cpu5 = roote.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue11 = cpu5.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docf = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet1&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootf = docf.root		#mark the top of the xml data
cpu6 = rootf.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue12 = cpu6.to_s()[5...-6].to_f	#convert the nodeset to a readable value

serversprodcpu = Array.new
serversprodcpu << {name: "STAGING", progress: metervalue7}
serversprodcpu << {name: "PRODUCTION", progress: metervalue8}
serversprodcpu << {name: "STAGING2", progress: metervalue12}
serversprodcpu << {name: "PRODUCTION2", progress: metervalue9}
serversprodcpu << {name: "NON CORE", progress: metervalue10}
serversprodcpu << {name: "MS SQL", progress: metervalue11}

   send_event('production-servers', {title: "PRODUCTION CPU USAGE", progress_items: serversprodcpu})
end
