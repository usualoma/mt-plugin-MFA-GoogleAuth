# MFA-GoogleAuth

This is a plugin for the Movable Type.
This plugin enables multi factor authentication by the google authenticator.

## Installation

1. Install [MFA plugin](https://github.com/usualoma/mt-plugin-MFA) to the MT.
1. Download an archive file from [releases](https://github.com/usualoma/mt-plugin-MFA-GoogleAuth/releases).
1. Unpack an archive file.
1. Upload unpacked files to the MT `plugins` directory.

Should look like this when installed:

    $MT_HOME/
        plugins/
            MFA-GoogleAuth/

## Requirements

* Movable Type 6 or Movable Type 7
* [MFA plugin](https://github.com/usualoma/mt-plugin-MFA)

## Recommends

I strongly recommend installing Math::Random::MT. 
If it is installed, a token is generated with a more secure algorithm.

* [Math::Random::MT](http://search.cpan.org/~fangly/Math-Random-MT-1.17/)

## LICENSE

Copyright (c) 2017 Taku AMANO

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
