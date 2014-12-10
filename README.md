Neo4j Puppet Module
===================

Automates installing Neo4j on an EC2 Linux system.

About
-----

This module will install Neo4j, and its dependencies (e.g. a JVM).  It's designed to run on a server and expose the REST
API over the network.

Features
--------

* Installs Neo4j enterprise from stable Debian packages
* Installs suitable JVM

Usage
--------------
```
class { neo4j: }
```

License
-------

Apache 2


Please log tickets and issues at the [Github project](https://github.com/neo4j-contrib/neo4j-puppet).

Acknowledgements
----------------

Thanks to:

* [Jussi Heinonen](https://github.com/jussiheinonen) for inspiration

* [Hendy Irawan](http://www.hendyirawan.com/) for letting us pinch some code
