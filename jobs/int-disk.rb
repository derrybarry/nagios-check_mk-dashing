
require 'curb'
require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'json'

SCHEDULER.every '600s', :first_in => 0 do |job|

doc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=***&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
root = doc.root		#mark the top of the xml data
max = root.xpath("//MAX").first# search for tags that match "act" there is only one set
max = max.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpu = root.xpath("//ACT")# search for tags that match "act" there is only one set
acpu = acpu.to_s()[5...-6].to_f	/ 1000 .round(3)#convert the nodeset to a string

used = acpu.fdiv(max)*100
free = used.round #convert difference as a percentage

docb = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=***&srv=fs_/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootb = docb.root		#mark the top of the xml data
maxb = rootb.xpath("//MAX").first# search for tags that match "act" there is only one set
maxb = maxb.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpub = rootb.xpath("//ACT")# search for tags that match "act" there is only one set
acpub = acpub.to_s()[5...-6].to_f	/ 1000 .round(3)#convert the nodeset to a string

usedb = acpub.fdiv(maxb)*100
free2 = usedb.round #convert difference as a percentage

docc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=***&srv=fs_D:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootc = docc.root		#mark the top of the xml data
maxc = rootc.xpath("//MAX").first# search for tags that match "act" there is only one set
maxc = maxc.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpuc = rootc.xpath("//ACT")# search for tags that match "act" there is only one set
acpuc = acpuc.to_s()[5...-6].to_f	/ 1000 .round(3)#convert the nodeset to a string

usedc = acpuc.fdiv(maxc)*100
free3 = usedc.round #convert difference as a percentage

docd = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=***&srv=fs_C:/ClusterStorage/Volume1/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootd = docd.root		#mark the top of the xml data
maxd = rootd.xpath("//MAX").first# search for tags that match "act" there is only one set
maxd = maxd.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpud = rootd.xpath("//ACT")# search for tags that match "act" there is only one set
acpud = acpud.to_s()[5...-6].to_f / 1000 .round(3)#convert the nodeset to a string

usedd = acpud.fdiv(maxd)*100
free4 = usedd.round #convert difference as a percentage



servers = Array.new
servers << {name: "SQL 2008R2", progress: free}
servers << {name: "VCS-01", progress: free2}
servers << {name: "FILES", progress: free3}
servers << {name: "CLUSTER 1", progress: free4}

  #send_event('servers', { series: [{ name: 'servers', data: ti_data }], categories: ti_cats, color: '#2c3e50' })
send_event('int-disk', {title: "INTERNAL DISK SPACE (USED)", progress_items: servers})
end
