#!/bin/bash

curl -i -d 'identifier=jumpstartlab&rootUrl=http://jumpstartlab.com'  http://localhost:9393/sources
curl -i -d 'identifier=google&rootUrl=http://google.com'  http://localhost:9393/sources
curl -i -d 'identifier=apple&rootUrl=http://apple.com'  http://localhost:9393/sources
curl -i -d 'identifier=microsoft&rootUrl=http://microsoft.com'  http://localhost:9393/sources
curl -i -d 'identifier=palantir&rootUrl=http://palantir.com'  http://localhost:9393/sources
curl -i -d 'identifier=yahoo&rootUrl=http://yahoo.com'  http://localhost:9393/sources
curl -i -d 'identifier=turing&rootUrl=http://turing.io'  http://localhost:9393/sources
curl -i -d 'identifier=facebook&rootUrl=http://facebook.com'  http://localhost:9393/sources

curl -i -d 'payload={"url":"http://jumpstartlab.com/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' http://localhost:9393/sources/jumpstartlab/data

curl -i -d 'payload={"url":"http://apple.com/blog","requestedAt":"2014-02-16 21:38:28 -0700","respondedIn":105,"referredBy":"http://apple.com","requestType":"GET","parameters":[],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"640","resolutionHeight":"480","ip":"63.29.38.212"}' http://localhost:9393/sources/apple/data

curl -i -d 'payload={"url":"http://google.com/about","requestedAt":"2013-01-16 21:38:28 -0700","respondedIn":90,"referredBy":"http://apple.com","requestType":"POST","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"}' http://localhost:9393/sources/google/data

curl -i -d 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 21:38:28 -0700","respondedIn":37,"referredBy":"http://apple.com","requestType":"GET","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}' http://localhost:9393/sources/yahoo/data

curl -i -d 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 22:38:28 -0700","respondedIn":37,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["what","huh"],"eventName": "beginRegistration","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"500","resolutionHeight":"700","ip":"63.29.38.214"}' http://localhost:9393/sources/yahoo/data

curl -i -d 'payload={"url":"http://yahoo.com/weather","requestedAt":"2013-01-13 12:38:28 -0700","respondedIn":200,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "socialLogin","userAgent":"Mozilla/5.0 (Windows%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"63.29.38.214"}' http://localhost:9393/sources/yahoo/data

curl -i -d 'payload={"url":"http://google.com/about","requestedAt":"2013-01-16 24:38:28 -0700","respondedIn":540,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["what","huh"],"eventName": "socialLogin","userAgent":"Mozilla/4.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1080","ip":"63.29.38.213"}' http://localhost:9393/sources/google/data

curl -i -d 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2013-01-14 21:38:28 -0700","respondedIn":123,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"72.29.38.214"}' http://localhost:9393/sources/yahoo/data

curl -i -d 'payload={"url":"http://yahoo.com/not_news","requestedAt":"2013-01-14 21:38:28 -0700","respondedIn":130,"referredBy":"http://jumpstartlab.com","requestType":"GET","parameters":["slow"],"eventName": "beginRegistration","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"800","resolutionHeight":"600","ip":"92.29.38.214"}' http://localhost:9393/sources/yahoo/data

curl -i -d 'payload={"url":"http://yahoo.com/chat_room","requestedAt":"2015-01-14 21:38:28 -0700","respondedIn":10,"referredBy":"http://jumpstartlab.com","requestType":"POST","parameters":["slow"],"eventName": "chatting","userAgent":"Mozilla/3.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Firefox/24.0.1309.0 Safari/537.17","resolutionWidth":"1000","resolutionHeight":"1000","ip":"88.88.88.888"}' http://localhost:9393/sources/yahoo/data
