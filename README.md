h2tp
----

A simple HTTP file server written in Go Lang.


## Configuration

By default, the server will look for a file named `config.json` on the same path of the executable. When the process didn't locate this file nor custom configurations are given at command line, the server will run using the following configuration:

```json
{
  "port": 5000,
  "path": "."
}
```

You can change this behavior specifying a different location for the config file using the flag `config` on the command line.

```sh
h2tp -conf=/path/to/config.json
```

Some arguments are allowed to be overridden, individually, using specific parameters.
E.g.:

* `path`: the path to be listed
* `port`:  the listening port

All arguments could be checked using the help argument:

```sh
h2tp --help
```