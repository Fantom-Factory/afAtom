#Atom v1.0.2
---
[![Written in: Fantom](http://img.shields.io/badge/written%20in-Fantom-lightgray.svg)](http://fantom.org/)
[![pod: v1.0.2](http://img.shields.io/badge/pod-v1.0.2-yellow.svg)](http://www.fantomfactory.org/pods/afAtom)
![Licence: MIT](http://img.shields.io/badge/licence-MIT-blue.svg)

## Overview

*Atom is a support library that aids Alien-Factory in the development of other libraries, frameworks and applications. Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

Atom is a library for creating Atom (RSS) Feed Documents.

The [Atom Syndication Format](http://tools.ietf.org/html/rfc4287), or Atom for short, is the technically advanced successor to [RSS v2.0](http://www.rssboard.org/rss-specification). This Atom library provides a collection of entities that let you compose an Atom Feed Document and serialise it to XML.

Atom is an implementation of the [The Atom Syndication Format](http://tools.ietf.org/html/rfc4287). See [atomenabled.org](http://atomenabled.org/developers/syndication) for a more human readable version.

## Install

Install `Atom` with the Fantom Repository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afAtom

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afAtom 1.0"]

## Documentation

Full API & fandocs are available on the [Status302 repository](http://repo.status302.com/doc/afAtom/).

## Quick Start

1. Create a text file called `Example.fan`:

        using afAtom
        
        class Example {
            Void main() {
        
                // create a feed...
                feed := Feed(`example:feed`, Text("Fantom Feed"), DateTime.now)
                feed.links.add(Link(`http://www.fantomfactory.org/`, "alternate") {
                    it.title = "Fantom-Factory"
                    it.type  = MimeType("application/xhtml+xml")
                })
        
                // add entries...
                text  := "<p>Visit the <b>Atom</b> homepage to find out moar!</p>"
                entry := Entry(`example:afAtom:`, Text("Atom Released!"), DateTime.now)
                entry.content = Content(text, TextType.html)
                feed.entries.add(entry)
        
                // convert to XML...
                atomXml := feed.toXml.writeToStr
                echo(atomXml)
            }
        }


2. Run `Example.fan` as a Fantom script from the command line:

        C:\> fan Example.fan
        
        <?xml version='1.0' encoding='UTF-8'?>
        <feed xmlns='http://www.w3.org/2005/Atom'>
            <id>example:feed</id>
            <title type='text'>Fantom Feed</title>
            <updated>2014-03-31T17:50:52.786+01:00</updated>
            <link href='http://www.fantomfactory.org/' rel='alternate' type='application/xhtml+xml' title='Fantom-Factory'/>
            <entry>
                <id>example:afAtom:</id>
                <title type='text'>Atom Released!</title>
                <updated>2014-03-31T17:50:52.786+01:00</updated>
                <content type='html'>&lt;p>Visit the &lt;b>Atom&lt;/b> homepage to find out moar!&lt;/p></content>
            </entry>
        </feed>



## BedSheet Integration

To serve an Atom feed with [BedSheet](http://pods.fantomfactory.org/pods/afBedSheet) first add a `Route` to your `AppModule` that configures the feed URI and the request handler:

```
using afIoc
using afBedSheet

class AppModule {

    @Contribute { serviceType=Routes# }
    static Void contributeRoutes(OrderedConfig config) {
        config.add(Route(`/feeds/atom.xml`, AtomFeed#generate))
    }
}
```

Then create the request handler that generates the Atom feed:

```
using afAtom
using afBedSheet::Text as BsText

class AtomFeedGenerator {
    BsText generate() {
        feed := Feed(`example:feed`, Text("Example Feed"), DateTime.now)

        // add feed metadata and entries...
        feed.entries.add(Entry(`example:entry:`, Text("Example Entry"), DateTime.now))

        // serialise to XML and return as a BedSheet Text response object
        return BsText.fromMimeType(feed.toXml.writeToStr, MimeType("application/atom+xml"))
    }
}
```

Note that Atom feeds should be served with the `application/atom+xml` mime type.

## Auto-Discovery

Some browsers, such as [Firefox](http://toodifficult.com/keeping-up-with-news-using-rss/), automatically know when a site has an Atom or RSS feed and contain features to easily let you subscribe. To enable this, you need to add a bit of HTML to your web page:

```
<html>
<head>
    ...
    <link rel="alternate" type="application/atom+xml" title="Feed Title" href="/feeds/atom.xml">
    ...
```

If you have multiple feeds, then you may have multiple `link` elements.

Note that in HTML the `link` element is a [Void Element](http://www.w3.org/TR/html-markup/syntax.html#void-element) and has no closing tag.

This old article in the WHATWG Blog on [Feed Autodiscovery](http://blog.whatwg.org/feed-autodiscovery) talks of a new standard where `feed` is used for the link `rel` attribute. But its absence in the HTML5 specification on [Link types](http://www.w3.org/TR/html5/links.html#linkTypes) suggests it never took off. Also [Section 4.8.4.1 Link type "alternate"](http://www.w3.org/TR/html5/links.html#rel-alternate) specifically says `alternate` should be used for Atom and RSS feeds.

