# basecv

This is a small and simple command line tool to convert numbers between bases. All bases that are displayable with digits
and the latin alphabet [2-36] are supported.

For now only integers are supported.

## Installation

TODO: Write installation instructions here

## Usage

```console
Usage: basecv [options] <num>
    -f <base>, --from <base>         Base of the input [2-36], default=10
    -t <base>, --to <base>           Base of the output [2-36], default=16
    -u, --upcase                     Upcase the result
    -h, --help                       Show this help
```
Negative numbers have to be passed with a '--' in front of them.

### Examples:
Convert "100" from decimal to hexadecimal:
```console 
$ basecv 100
64
```
Convert "-17" from decimal to binary: 
```console 
$ basecv -t 2 -- -17
-10001
```
Convert "ABC" from hexadecimal to binary:
```console 
$ basecv -f 16 -t 2 ABC
101010111100
```
Convert "22222222222221222222222" from ternary to octodecimal (for whatever reason...):
```console 
$ basecv -f 3 -t 18 22222222222221222222222
89dga8hhh
```
## Contributing

1. Fork it (<https://github.com/lucamathias/basecv/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Luca Mathias](https://github.com/lucamathias) - creator and maintainer
