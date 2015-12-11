# TrafficSpy
## An application for tracking website traffic

### Authors

This application was created by [Beth Secor](https://github.com/bethsecor), [Steve Pentler](https://github.com/stevepentler), and [Toni Rib](https://github.com/tonirib) for the [Turing School of Software & Design](http://turing.io).

### Overview

stuff here.

### Registering an Application

Applications are registered through the terminal using the `curl` command in the following format:

```
curl -i -d 'identifier=turing&rootUrl=http://turing.io'  http://localhost:9393/sources
```

The identifier chosen will be used to reference that application through the site. If either the identifier or the rootUrl parameters are missing, an error will be thrown. In addition, an application can only be registered once.

### Sending Application Data (Payloads)

In order to mimic data being sent to our server, you can again use the terminal `curl` command in the following format to send a payload:

```
curl -i -d 'payload={"url":"http://turing.io/blog","requestedAt":"2013-02-16 21:38:28 -0700","respondedIn":37,"referredBy":"http://turing.io","requestType":"GET","parameters":[],"eventName":"socialLogin","userAgent":"Mozilla/5.0 (Macintosh%3B Intel Mac OS X 10_8_2) AppleWebKit/537.17 (KHTML, like Gecko) Chrome/24.0.1309.0 Safari/537.17","resolutionWidth":"1920","resolutionHeight":"1280","ip":"63.29.38.211"}' http://localhost:9393/sources/turing/data
```

Payloads can only be sent one time, but the entire contents of the payload must be identical in order for it to be rejected as a duplicate.
