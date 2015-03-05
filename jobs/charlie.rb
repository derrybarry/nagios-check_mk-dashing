#!/usr/bin/env ruby
require 'net/http'
#require 'csv'
require 'httparty'
require 'open-uri'
# Check whether a server is responding
# 

SCHEDULER.every '30s', :first_in => 0 do |job|
 
	
	# check status for server
			s = HTTParty.get('https://charliespm.com/md5 hash check.cfm')
	
		siteMd5 = '******'
		strcomp = s.strip <=> siteMd5.strip
		comparison = s + ' against ' + siteMd5
				if strcomp == 0
			result = '1(site is up)'
			 else
			 result = '4 ( DOH! ) '
			 end
 
	# print statuses to dashboard
	send_event('charlie', {value: result})
end
