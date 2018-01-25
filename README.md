# http-host.nse

`nmap` script which fixes the `Host` header.

***

## Dependencies

+ `nmap` :trollface:

*** 

## Usage

~~~bash
jbono@MacBook [~]> nmap --script http-host.nse --script-args "http-host.host_header='evilsite.com'" google.com

 @output
 PORT   STATE SERVICE
 80/tcp open  http
 | http-host:
 |   Content-Type: text/html; charset=UTF-8
 |   Referrer-Policy: no-referrer
 |   Content-Length: 1561
 |   Date: Thu, 25 Jan 2018 15:13:38 GMT
 |   Connection: close
 |
 |_  Using HTTP Header --> Host: evilsite.com

~~~

Network trace:

~~~bash
GET / HTTP/1.1
User-Agent: Mozilla/5.0 (X11;U; Linux i686; en-US; rv:1.9a3pre) Gecko/20070330
Connection: close
Host: evilsite.com
~~~
