[![][travis-badge]][travis-link]
![][license-badge]

<div align="center">
  <a href="http://github.com/oh-my-fish/oh-my-fish">
  <img width=90px  src="https://cloud.githubusercontent.com/assets/8317250/8510172/f006f0a4-230f-11e5-98b6-5c2e3c87088f.png">
  </a>
</div>
<br>

# cd

Plugin for [Oh My Fish][omf-link].

Package cd provides a new `cd` command to help you change the current working directory fast. It's a proxy directive of the buildin `cd` command with an alise of going to the upper directory.

I used to enjoy this feature all the time in zsh. I don't see any reason my dear fish should not have it.

## Install

```fish
$ omf install cd
```


## Usage

```fish
$ cd .../foo           # <=> cd ../../foo
$ cd ...               # <=> cd ../..
$ cd .../foo/.../bar   # <=> cd ../../foo/../../bar
```

# License

[MIT][mit] © [Jianming Qu](https://jmqu.tech)


[mit]:            http://opensource.org/licenses/MIT
[author]:         http://github.com/sancoder-q
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
[travis-badge]:   http://img.shields.io/travis/sancoder-q/plugin-cd.svg?style=flat-square
[travis-link]:    https://travis-ci.org/sancoder-q/plugin-cd
