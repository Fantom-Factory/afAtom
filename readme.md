# Atom

*`Atom` is a support library that aids Alien-Factory in the development of other libraries, frameworks and applications.
Though you are welcome to use it, you may find features are missing and the documentation incomplete.*

`Atom` is a [Fantom](http://fantom.org/) library for creating Atom (RSS) Feed Documents.

The [Atom Syndication Format](http://tools.ietf.org/html/rfc4287), or Atom for short, is the technically advanced successor to [RSS v2.0](http://www.rssboard.org/rss-specification).
This `Atom` library provides a collection of entities that let you compose an Atom Feed Document and serialise it to XML.

`Atom` is an implementation of the [The Atom Syndication Format](http://tools.ietf.org/html/rfc4287).
See [atomenabled.org](http://atomenabled.org/developers/syndication) for a more human readable version.



## Install

Install `Atom` with the Fantom Respository Manager ( [fanr](http://fantom.org/doc/docFanr/Tool.html#install) ):

    C:\> fanr install -r http://repo.status302.com/fanr/ afAtom

To use in a [Fantom](http://fantom.org/) project, add a dependency to `build.fan`:

    depends = ["sys 1.0", ..., "afAtom 1.0+"]



## Documentation

Full API & fandocs are available on the [status302 repository](http://repo.status302.com/doc/afAtom/#overview).



## Quick Start

1). Create a text file called `Example.fan`:

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

2). Run `Example.fan` as a Fantom script from the command line:

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

