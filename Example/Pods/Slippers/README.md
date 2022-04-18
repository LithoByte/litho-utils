# Slippers

[![CI Status](https://circleci.com/gh/ThryvInc/slippers.svg?style=svg)](https://circleci.com/gh/ThryvInc/slippers)
[![Version](https://img.shields.io/cocoapods/v/Slippers.svg?style=flat)](https://cocoapods.org/pods/Slippers)
[![License](https://img.shields.io/cocoapods/l/Slippers.svg?style=flat)](https://cocoapods.org/pods/Slippers)
[![Platform](https://img.shields.io/cocoapods/p/Slippers.svg?style=flat)](https://cocoapods.org/pods/Slippers)

Slippers adds some structure around common networking tasks like refreshing, paging, and json parsing.

Specifically, it provides:
- A protocol called `Refreshable` which requires a `refresh` function
- A functional implementation of `Refreshable`
- A 'meta' refresher class which will accept bunch of refreshables and refresh all of them on command
- A protocol called `Pageable` which requires `nextPage` and `fetchPage` functions
- A functional implementation of `Pageable` + `Refreshable` that manages the page number for you
- An extension to `Pageable` that can be used with `UITableViewDelegate`s to simplify infinite lists
- An extension to `Pageable` that can be used with `UICollectionViewDelegate`s to simplify infinite lists
- An array extension that allows you to use a simple array to simulate paginated batches of elements
- A class that makes a single `JSONEncoder` and `JSONDecoder` available throughout your project with smart defaults set on them
- An `Id` class that you can use transparently for integer server ids which helps enforce type consistency when passed around

## Installation

To install Slippers, simply add the following line to your Podfile:

```ruby
pod 'Slippers', git: 'https://github.com/ThryvInc/slippers'
```

## Author

Elliot Schrock

## License

Slippers is available under the MIT license. See the LICENSE file for more info.
