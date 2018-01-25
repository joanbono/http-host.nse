local http = require "http"
local nmap = require "nmap"
local shortport = require "shortport"
local stdnse = require "stdnse"
local table = require "table"

description = [[
GET request using given Host Header
]]

--- nmap <options> --script http-host.nse --script-args "http-host.host_header='evilsite.com'"
-- @output
-- PORT   STATE SERVICE
-- 80/tcp open  http
-- | http-host:
-- |   Content-Type: text/html; charset=UTF-8
-- |   Referrer-Policy: no-referrer
-- |   Content-Length: 1561
-- |   Date: Thu, 25 Jan 2018 15:13:38 GMT
-- |   Connection: close
-- |
-- |_  Using HTTP Header --> Host: evilsite.com
--

author = "Joan Bono <@joan_bono>"

license = "Same as Nmap" --See https://nmap.org/book/man-legal.html

portrule = shortport.port_or_service( {80, 443, 8080, 8443}, {"http", "https"}, "tcp", "open")

action = function(host, port)
  local path = "/"
  local request_type = "GET"
  local host_header = stdnse.get_script_args("http-host.host_header")
  local result
  local options = {header={}, no_cache=true}

  options['header']['Host'] = host_header
  options['header']['User-Agent'] = "Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9a3pre) Gecko/20070330"
  options['redirect_ok'] = 5

  result = http.get(host, port, path, options)

  table.insert(result.rawheader, "Using HTTP Header --> Host: ".. host_header )

  return stdnse.format_output(true, result.rawheader)
end
