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

Package cd provides a new `cd` command to help you change the current working directory fast. It's a wrapper directive of the built-in `cd` command with many useful features and powerful completions.

## Features:

- Multi-dot navigation: `cd ....`
- Plus / minus navigation: `cd -` `cd -3` `cd +2`
- Full `$CDPATH` support

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

```fish
$ cd                   # ~
$ cd ~/foo             # ~/foo
$ cd ~/bar             # ~/bar
$ cd -                 # ~/foo ;; ( Equal to `cd -1` )
```

```fish
$ pwd                  # ~/a
$ cd ~/b               # ~/b ;; ( dirstack: a )
$ cd ~/c               # ~/c ;; ( dirstack: b a )
$ cd ~/d               # ~/d ;; ( dirstack: c b a )
$ cd -2                # ~/b ;; ( dirstack: d c a )
$ cd +1                # ~/c ;; ( dirstack: b d a )
$ cd +0                # ~/a ;; ( dirstack: c b d )
$ cd -0                # ~/a ;; ( dirstack: c b d )
```

# License

[MIT][mit] © [Jianming Qu](https://jmqu.tech)


[mit]:            http://opensource.org/licenses/MIT
[author]:         http://github.com/sancoder-q
[omf-link]:       https://www.github.com/oh-my-fish/oh-my-fish

[license-badge]:  https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square
[travis-badge]:   http://img.shields.io/travis/sancoder-q/plugin-cd.svg?style=flat-square
[travis-link]:    https://travis-ci.org/sancoder-q/plugin-cd
