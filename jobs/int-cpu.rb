### TOP 10 INSTRUMENTS
require 'curb'
require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'json'

SCHEDULER.every '30s', :first_in => 0 do |job|

doc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=papa&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
roota = doc.root		#mark the top of the xml data
cpu1 = roota.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue = cpu1.to_s()[5...-6].to_i	#convert the nodeset to a readable value

docb = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=quebec&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootb = docb.root		#mark the top of the xml data
cpu2 = rootb.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue2 = cpu2.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=SQL2008R2&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootc = docc.root		#mark the top of the xml data
cpu3 = rootc.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue3 = cpu3.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docd = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=EXCH01&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootd = docd.root		#mark the top of the xml data
cpu4 = rootd.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue4 = cpu4.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docf = Nokogiri::XML(open("http://+++pnp4nagios/index.php/xml?host=VCS01&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootf = docf.root		#mark the top of the xml data
cpu6 = rootf.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue6 = cpu6.to_s()[5...-6].to_f	#convert the nodeset to a readable value

docg = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=VNODE1&srv=CPU_utilization", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootg = docg.root		#mark the top of the xml data
cpu7 = rootg.xpath("//ACT")# search for tags that match "act" there is only one set
metervalue7 = cpu7.to_s()[5...-6].to_f	#convert the nodeset to a readable value

servers = Array.new
servers << {name: "TESTING-SRV1", progress: metervalue}
servers << {name: "TESTING-SRV2", progress: metervalue2}
servers << {name: "SQL-TEST", progress: metervalue3}
servers << {name: "EXCHANGE", progress: metervalue4}
servers << {name: "SUBVERSION", progress: metervalue6}
servers << {name: "VNODE 1", progress: metervalue7}


  #servers = [["TESTING-SRV1", metervalue], ["TESTING-SRV2", metervalue2], ["SQL-TEST", metervalue3], ["EXCHANGE ", metervalue4], ["SUBVERSION", metervalue6]]

  #servers = servers.sort_by{|k|k[1]}
  #servers.reverse!

  #ti_cats = servers.map { |list| list[0] }
  #ti_data = servers.map { |list| list[1] }

  #send_event('internal-cpu', { series: [{ name: 'servers', data: ti_data }], categories: ti_cats, color: '#2c3e50' })
send_event('internal-cpu', {title: "INTERNAL CPU USAGE", progress_items: servers})
end
