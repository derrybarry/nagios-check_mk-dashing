
require 'curb'
require 'httparty'
require 'open-uri'
require 'nokogiri'
require 'json'

SCHEDULER.every '600s', :first_in => 0 do |job|

doc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
root = doc.root		#mark the top of the xml data
max = root.xpath("//MAX").first# search for tags that match "act" there is only one set
max = max.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpu = root.xpath("//ACT")# search for tags that match "act" there is only one set
acpu = acpu.to_s()[5...-6].to_f	/ 1000 .round(3)#convert the nodeset to a string

used = acpu.fdiv(max)*100
free = used.round #convert difference as a percentage

docb = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet2&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootb = docb.root		#mark the top of the xml data
maxb = rootb.xpath("//MAX").first# search for tags that match "act" there is only one set
maxb = maxb.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpub = rootb.xpath("//ACT")# search for tags that match "act" there is only one set
acpub = acpub.to_s()[5...-6].to_f	/ 1000 .round(3)#convert the nodeset to a string

usedb = acpub.fdiv(maxb)*100
free2 = usedb.round #convert difference as a percentage

docc = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet1&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootc = docc.root		#mark the top of the xml data
maxc = rootc.xpath("//MAX").first# search for tags that match "act" there is only one set
maxc = maxc.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpuc = rootc.xpath("//ACT")# search for tags that match "act" there is only one set
acpuc = acpuc.to_s()[5...-6].to_f	/ 1000 .round(3)#convert the nodeset to a string

usedc = acpuc.fdiv(max)*100
free3 = usedc.round #convert difference as a percentage

docd = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=kilo&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootd = docd.root		#mark the top of the xml data
maxd = rootd.xpath("//MAX").first# search for tags that match "act" there is only one set
maxd = maxd.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpud = rootd.xpath("//ACT")# search for tags that match "act" there is only one set
acpud = acpud.to_s()[5...-6].to_f / 1000 .round(3)#convert the nodeset to a string

usedd = acpud.fdiv(maxd)*100
free4 = usedd.round #convert difference as a percentage


docm = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=juliet3&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootm = docm.root		#mark the top of the xml data
maxm = rootm.xpath("//MAX").first# search for tags that match "act" there is only one set
maxm = maxm.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpum = rootm.xpath("//ACT")# search for tags that match "act" there is only one set
acpum = acpum.to_s()[5...-6].to_f / 1000 .round(3)#convert the nodeset to a string

usedm = acpum.fdiv(maxd)*100
free15 = usedm.round #convert difference as a percentage

docn = Nokogiri::XML(open("http://+++/pnp4nagios/index.php/xml?host=RS-WEB4&srv=fs_C:/", http_basic_authentication: ["login", "pwd"]).read)	# load it into the nokogiri gem
rootn = docn.root		#mark the top of the xml data
maxn = rootn.xpath("//MAX").first# search for tags that match "act" there is only one set
maxn = maxn.to_s()[5...-6].to_f / 1000 .round(3)	#convert the nodeset to a string
acpun = rootn.xpath("//ACT")# search for tags that match "act" there is only one set
acpun = acpun.to_s()[5...-6].to_f / 1000 .round(3)#convert the nodeset to a string

usedn = acpun.fdiv(maxd)*100
free16 = usedn.round #convert difference as a percentage

servers = Array.new
servers << {name: "STAGING", progress: free}
servers << {name: "PRODUCTION", progress: free2}
servers << {name: "STAGING2", progress: free3}
servers << {name: "PRODUCTION2", progress: free15}
servers << {name: "MS SQL", progress: free4}
servers << {name: "NON CORE", progress: free16}

  #send_event('servers', { series: [{ name: 'servers', data: ti_data }], categories: ti_cats, color: '#2c3e50' })
send_event('prod-disk', {title: "PRODUCTION DISK SPACE (USED)", progress_items: servers})
end
